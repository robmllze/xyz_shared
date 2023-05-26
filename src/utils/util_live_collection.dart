import 'dart:async';

import '/all.dart';

class LiveCollection<T> {
  static const KEY_INDEX = "__index__";
  final CollectionReference<Json> ref;

  final T Function(Json) fromMapper;
  final Json Function(T) toMapper;

  StreamSubscription<QuerySnapshot<Json>>? _stream;

  LiveCollection({required this.ref, required this.fromMapper, required this.toMapper});

  final pData = PodMap<String, T>({});
  final pRefresh = Pod<void>(null);

  Pod<T>? pDocument(String key) => this.pData[key];
  int get length => this.pData.pods.length;

  Future<void> addDocument(T input) {
    final data = this.toMapper(input);
    return this.ref.add(data);
  }

  Future<void> setDocument(String id, T input) {
    final data = this.toMapper(input);
    return this.ref.doc(id).set(data, SetOptions(merge: true));
  }

  Future<void> restart({
    int? limit,
    void Function(String id, T data)? onAdded,
    void Function(String id, T data)? onChanged,
    void Function(String id)? onRemoved,
  }) async {
    await this.stop();
    this._stream =
        (limit == null ? ref : ref.limit(limit)).snapshots().listen((final querySnapshot) {
      final docChanges = querySnapshot.docChanges;
      for (final change in docChanges) {
        final index = change.newIndex;
        final id = change.doc.id;
        if (index == -1) {
          this.pData[id]?.dispose();
          this.pData.pods.remove(id);
          () async {
            await this.pRefresh.refresh();
            onRemoved?.call(id);
            //print("REMOVED");
          }();
          continue;
        }
        final doc = change.doc;
        final data = doc.data();
        if (data != null) {
          data[KEY_INDEX] = index;
          final mapped = fromMapper(data);
          final pod = this.pData[id];
          if (pod == null) {
            this.pData.pods[id] ??= Pod<T>(mapped);
            () async {
              await this.pRefresh.refresh();
              onAdded?.call(id, mapped);
              //print("ADDED");
            }();
          } else {
            () async {
              await pod.set(mapped);
              await this.pRefresh.refresh();
              onChanged?.call(id, mapped);
              //print("CHANGED");
            }();
          }
        }
      }
    });
  }

  Future<void> stop() async => await this._stream?.cancel();

  Future<void> dispose() async {
    await this.stop();
    await this.pData.dispose();
    await this.pRefresh.dispose();
  }
}
