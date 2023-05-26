import 'dart:async';

import '/all.dart';

class LiveCollection<T> {
  static const KEY_INDEX = "__index__";
  final CollectionReference<Json> ref;

  final T Function(Json) fromMapper;
  final Json Function(T) toMapper;

  StreamSubscription<QuerySnapshot<Json>>? _stream;

  LiveCollection({required this.ref, required this.fromMapper, required this.toMapper});

  final pValues = <String, Pod<T>?>{};

  Pod<T>? pDocument(String key) => this.pValues[key];
  int get length => this.pValues.length;

  Future<void> addDocument(T input) {
    final data = this.toMapper(input);
    return this.ref.add(data);
  }

  Future<void> setDocument(String id, T input) {
    final data = this.toMapper(input);
    return this.ref.doc(id).set(data, SetOptions(merge: true));
  }

  final _queue = FunctionQueue();

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
          this.pValues[id]?.dispose();
          this.pValues.remove(id);
          onRemoved?.call(id);
          continue;
        }
        final doc = change.doc;
        final data = doc.data();
        if (data != null) {
          data[KEY_INDEX] = index;
          final mapped = fromMapper(data);
          final pod = this.pValues[id];
          if (pod == null) {
            this.pValues[id] ??= Pod<T>(mapped);
            onAdded?.call(id, mapped);
          } else {
            this._queue.add(() => pod.set(mapped));
            onChanged?.call(id, mapped);
          }
        }
      }
    });
  }

  Future<void> stop() async => await this._stream?.cancel();

  Future<void> _disposeAndEmptyPods() async {
    final pods = this.pValues.values;
    for (final pod in pods) {
      await pod?.dispose();
    }
    this.pValues.clear();
  }

  Future<void> dispose() async {
    await this.stop();
    await this._disposeAndEmptyPods();
  }
}
