// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

part 'model_event_data.g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateModel(
  parameters: {
    "body": "Map|clean<String?, dynamic>?",
    "dateSent": "DateTime?",
    "timesDelivered": "Map|clean<String?, Timestamp?>?",
    "timesRead": "Map|clean<String?, Timestamp?>?",
    "isSent": "bool?",
    "isDelivered": "bool?",
    "isRead": "bool?",
    "isArchived": "bool?",
    "isHidden": "bool?",
    "isLiked": "bool?",
    "lifespan": "Duration?",
    "pathEvents": "String?",
    "reciever": "ModelUserData?",
    "sender": "ModelUserData?",
    "type": "EventType?",
  },
)
abstract class ModelEventDataUtils extends XyzModel {
  ModelEventDataUtils._();
}
