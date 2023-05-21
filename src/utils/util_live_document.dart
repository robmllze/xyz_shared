// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async' show StreamSubscription;

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class LiveDocument<T> {
  /// The Firestore document reference.
  final DocumentReference<Json> ref;

  /// A function that maps a JSON object to a `T` object.
  final T Function(Json) fromMapper;

  /// A function that maps a `T` object to a JSON object.
  final Json Function(T) toMapper;

  /// The Pod that stores the current value of the document.
  final Pod<T> pValue;

  /// A queue of functions that need to be executed in order.
  final _queue = FunctionQueue();

  /// The stream subscription that listens for changes to the document.
  late final StreamSubscription<DocumentSnapshot<Json>> _stream;

  LiveDocument._({
    required this.ref,
    required this.toMapper,
    required this.fromMapper,
    required this.pValue,
  });

  /// Creates a new `LiveDocument` instance and starts listening for changes to
  /// the Firestore document.
  ///
  /// The `fromMapper` and `toMapper` functions are used to map between JSON
  /// objects and `T` objects. The `equals` function is used to compare two `T`
  /// objects for equality.
  static Future<LiveDocument<T>> start<T>({
    required DocumentReference<Json> ref,
    required T Function(Json) fromMapper,
    required Json Function(T) toMapper,
  }) async {
    final pValue = Pod<T>(fromMapper({}));
    final instance = LiveDocument<T>._(
      ref: ref,
      toMapper: toMapper,
      fromMapper: fromMapper,
      pValue: pValue,
    );

    try {
      await instance._refetch();
    } catch (_) {}

    // Listen for changes to the `Pod` instance and save the value to the
    // Firestore document.
    pValue.callbacks.add(instance.save);

    // Listen for changes to the Firestore document and update the value of the
    // `Pod` instance.
    instance._stream = ref.snapshots().listen((final snapshot) {
      final before = toMapper(pValue.value);
      final after = snapshot.data() ?? {};
      pValue.set(
        fromMapper(after),
        equals: (_, __) => equalsDeepCollection(before, after),
      );
    });

    return instance;
  }

  /// Refetches the Firestore document and updates the value of [pValue].
  Future<void> _refetch() async {
    final shapshot = await ref.get();
    final data = shapshot.data();
    if (data != null) {
      await this.pValue.set(fromMapper(data));
    }
  }

  /// Saves the current value of the document to Firestore and returns the
  /// same value.
  Future<T> save(_, T data) async {
    await this._queue.add(() {
      return this.ref.set(this.toMapper(data), SetOptions(merge: true));
    });
    return data;
  }

  /// Deletes the Firestore document.
  Future<void> delete() async {
    await this._queue.add(this.ref.delete);
  }

  /// Stops listening for changes to the Firestore document and disposes the
  /// `Pod` instance.
  Future<void> dispose() async {
    await this._stream.cancel();
    await this.pValue.dispose();
  }

  /// Calls [dispose] then [delete].
  Future<void> purge() async {
    await this.dispose();
    await this.delete();
  }
}
