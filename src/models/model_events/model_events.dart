// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

part 'model_events.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateModel(
  parameters: {
    "collection": "String?",
    "partTotal": "int|let?",
    "registry": "Map|clean<Timestamp|let, ModelEventData?>?",
    "timesLastRead": "Map|clean<String?, Timestamp?>?",
    "timesLastDelivered": "Map|clean<String?, Timestamp?>?",
    "idsParticipants": "Set|clean<String?>?",
    "keysUnread": "Map|clean<String?, Set|clean<Timestamp?>?>?",
    "keys": "Set|clean<Timestamp?>?",
  },
)
abstract class ModelEventsUtils extends XyzModel {
  //
  //
  //

  ModelEventsUtils._();

  //
  //
  //

  static DocumentReference<Json> refFirestore(String collection, String id) {
    return G.fbFirestore.collection(collection).doc(id);
  }

  //
  //
  //

  static Future<ModelEvents?> fromFirestore(String collection, String id) async {
    final snapshot = await refFirestore(collection, id).get();
    if (snapshot.exists) {
      final json = snapshot.data();
      if (json != null) {
        return ModelEvents.fromJson(json);
      }
    }
    return null;
  }

  //
  //
  //

  Future<void> toFirestore() async {
    final child = this as ModelEvents;
    final collection = child.collection;
    final id = this.id;
    if (collection != null && id != null) {
      final ref = ModelEventsUtils.refFirestore(collection, id);
      final json = this.toJson();
      try {
        await ref.setSafe(json, SetOptions(merge: true));
      } catch (e) {
        throw Exception(
          "Failed to write ModelEvents to Firestore: $e",
        );
      }
    }
  }
}
