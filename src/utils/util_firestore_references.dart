// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: camel_case_extensions

import 'dart:async';

import 'package:path/path.dart' as p;

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension FieldReference on DocumentReference<Json> {
  _FieldReference field(String path) => _FieldReference(path, this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _FieldReference {
  //
  //
  //

  final String path;
  final DocumentReference<dynamic> ref;
  const _FieldReference(this.path, this.ref);

  //
  //
  //

  Future<T?> get<T>() async {
    final data = (await this.ref.get()).data();
    if (data is Map) {
      return let<T>(data[this.path]);
    }
    return null;
  }

  //
  //
  //

  Future<bool> update(
    Future<dynamic> Function(dynamic) updator, {
    bool shouldCreateIfNonExistent = true,
    bool shouldMerge = true,
  }) {
    return G.fbFirestore.runTransaction(
      (final tr) async => await tr.get(this.ref).then((final snapshot) async {
        final dataOld = snapshot.data()?[this.path];
        if (!shouldCreateIfNonExistent && dataOld == null) return false;
        final dataNew = await updator(dataOld);
        if (dataNew != null) {
          tr.set(this.ref, {path: dataNew}, SetOptions(merge: shouldMerge));
          return true;
        }
        return false;
      }),
 
    );
  }

  //
  //
  //

  Future<bool> addToArrayTr(
    List<dynamic> elements, {
    bool shouldEnsureUniqueElements = true,
  }) {
    return this.update(
      (final data) async {
        if (data is List) {
          if (shouldEnsureUniqueElements) {
            final dataAsSet = data.toSet();
            dataAsSet.addAll(elements);
            return dataAsSet;
          }
          data.addAll(elements);
          return data;
        }
        return elements;
      },
    );
  }

  //
  //
  //

  Future<bool> removeFromArrayTr(List<dynamic> elements) {
    return this.update(
      (final data) async {
        if (data is List) {
          data.removeWhere((final e) => elements.contains(e));
          return data;
        }
      },
    );
  }

  //
  //
  //

  Future<void> addToArray(List<dynamic> elements) async {
    await ref.set(
      {this.path: FieldValue.arrayUnion(elements)},
      SetOptions(merge: true),
    );
  }

  //
  //
  //

  Future<void> removeFromArray(List<dynamic> elements) async {
    await ref.set(
      {this.path: FieldValue.arrayRemove(elements)},
      SetOptions(merge: true),
    );
  }

  //
  //
  //

  Future<void> delete() async {
    await ref.set(
      {this.path: FieldValue.delete()},
      SetOptions(merge: true),
    );
  }

  //
  //
  //

  Future<void> increment([num delta = 1]) async {
    await ref.set(
      {this.path: FieldValue.increment(delta)},
      SetOptions(merge: true),
    );
  }

  //
  //
  //

  Future<void> decrement([num delta = 1]) async {
    await ref.set(
      {this.path: FieldValue.increment(-delta)},
      SetOptions(merge: true),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension FirebaseFirestore_documentReference on FirebaseFirestore {
  DocumentReference<Json> documentReference(String path) {
    final segments = p.split(path);
    final length = segments.length;
    if (length == 0 || length.isOdd) {
      throw Exception("Invalid document path");
    }
    dynamic ref = this.collection(segments[0]);
    for (var n = 1; n < length; n++) {
      final segment = segments[n];
      ref = n.isOdd ? ref.doc(segment) : ref.collection(segment);
    }
    return ref;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension FirebaseFirestore_fieldReference on FirebaseFirestore {
  _FieldReference fieldReference(String path) {
    final segments = p.split(path);
    final length = segments.length - 1;
    if (length < 2 || length.isOdd) {
      throw Exception("Invalid field path");
    }
    final a = segments.take(length).toList();
    final b = segments.last;
    dynamic ref = this.collection(a[0]);
    for (var n = 1; n < length; n++) {
      final segment = a[n];
      ref = n.isOdd ? ref.doc(segment) : ref.collection(segment);
    }
    return (ref as DocumentReference<Json>).field(b);
  }
}
