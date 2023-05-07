// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

part 'model_event_data.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateModel(
  parameters: {
    "body": "Map|clean<String?, dynamic>?",
    "dateSent": "DateTime?",
    "eventsPath": "String?",
    "typeCode": "String?",
    "isArchived": "bool?",
    "isDelivered": "bool?",
    "isHidden": "bool?",
    "isLiked": "bool?",
    "isRead": "bool?",
    "isSent": "bool?",
    "lifespan": "Duration?",
    "sender": "ModelUserData?",
    "receiver": "ModelUserData?",
    "timesDelivered": "Map|clean<String?, Timestamp?>?",
    "timesRead": "Map|clean<String?, Timestamp?>?",
  },
)
abstract class ModelEventDataUtils extends XyzModel {
  ModelEventDataUtils._();
}
