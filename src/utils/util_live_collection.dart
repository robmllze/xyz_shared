import 'dart:async';

import '/all.dart';

class LiveCollection<T> {
  static const KEY_INDEX = "__index__";
  final CollectionReference<Json> ref;

  final T Function(Json) mapper;

  StreamSubscription<QuerySnapshot<Json>>? _stream;

  LiveCollection({required this.ref, required this.mapper});

  final _documents = <String, Pod<T>?>{};

  Pod<T>? getDocument(String key) => this._documents[key];
  int get length => this._documents.length;

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
          this._documents[id]?.dispose();
          this._documents.remove(id);
          onRemoved?.call(id);
          continue;
        }
        final doc = change.doc;
        final data = doc.data();
        if (data != null) {
          data[KEY_INDEX] = index;
          final mapped = mapper(data);
          final pod = this._documents[id];
          if (pod == null) {
            this._documents[id] ??= Pod<T>(mapped);
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
    final pods = this._documents.values;
    for (final pod in pods) {
      await pod?.dispose();
    }
    this._documents.clear();
  }

  Future<void> dispose() async {
    await this.stop();
    await this._disposeAndEmptyPods();
  }
}
