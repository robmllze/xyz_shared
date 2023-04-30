// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_message_data.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

class ModelMessageData extends ModelMessageDataUtils {
  //
  //
  //

  /// Related member: `this.id`;
  static const K_ID = "id";

  /// Related member: `this.args`;
  static const K_ARGS = "args";

  /// Key corresponding to the value `idRe`.
  static const K_ID_RE = "id_re";

  /// Value corresponding to the key `id_re` or [K_ID_RE].
  String? idRe;

  /// Key corresponding to the value `message`.
  static const K_MESSAGE = "message";

  /// Value corresponding to the key `message` or [K_MESSAGE].
  String? message;

  //
  //
  //

  /// Constructs a new instance of [ModelMessageData] identified by [id].
  ModelMessageData({
    String? id,
    dynamic args,
    this.idRe,
    this.message,
  }) : super._() {
    super.id = id;
    super.args = args;
  }

  /// Converts a [Json] object to a [ModelMessageData] object.
  factory ModelMessageData.fromJson(Json json) {
    try {
      return ModelMessageData(
        args: json[K_ARGS],
        id: (json[K_ID]?.toString()),
        idRe: (json[K_ID_RE]?.toString()),
        message: (json[K_MESSAGE]?.toString()),
      );
    } catch (e) {
      throw Exception(
        "[ModelMessageData.fromJson] Failed to convert JSON to ModelMessageData due to: $e",
      );
    }
  }

  /// Returns a copy of `this` model.
  @override
  T copy<T extends XyzModel>(T other) {
    return (ModelMessageData()..updateWith(other)) as T;
  }

  /// Converts a [ModelMessageData] object to a [Json] object.
  @override
  Json toJson() {
    try {
      return mapToJson(
        {
          K_ARGS: args,
          K_ID: id?.nullIfEmpty(),
          K_ID_RE: idRe?.nullIfEmpty(),
          K_MESSAGE: message?.nullIfEmpty(),
        }..removeWhere((_, final l) => l == null),
        typesAllowed: {Timestamp, FieldValue},
        // Defined in utils/timestamp.dart
        keyConverter: timestampKeyConverter,
      );
    } catch (e) {
      throw Exception(
        "[ModelMessageData.toJson] Failed to convert ModelMessageData to JSON due to: $e",
      );
    }
  }

  /// Returns a copy of `this` object with the fields in [other] overriding
  /// `this` fields. NB: [other] must be of type ModelMessageData.
  @override
  T newOverride<T extends XyzModel>(T other) {
    if (other is ModelMessageData) {
      return ModelMessageData(
        args: other.args ?? this.args,
        id: other.id ?? this.id,
        idRe: other.idRe ?? this.idRe,
        message: other.message ?? this.message,
      ) as T;
    }
    throw Exception(
      "[ModelMessageData.newOverride] Expected 'other' to be of type ModelMessageData and not ${other.runtimeType}",
    );
  }

  /// Returns a new empty instance of [ModelMessageData].
  @override
  T newEmpty<T extends XyzModel>() {
    return ModelMessageData() as T;
  }

  /// Updates `this` fields from the fields of [other].
  @override
  void updateWithJson(Json other) {
    this.updateWith(ModelMessageData.fromJson(other));
  }

  /// Updates `this` fields from the fields of [other].
  @override
  void updateWith<T extends XyzModel>(T other) {
    if (other is ModelMessageData) {
      if (other.args != null) {
        this.args = other.args;
      }
      if (other.id != null) {
        this.id = other.id;
      }
      if (other.idRe != null) {
        this.idRe = other.idRe;
      }
      if (other.message != null) {
        this.message = other.message;
      }
      return;
    }
    throw Exception(
      "[ModelMessageData.updateWith] Expected 'other' to be of type ModelMessageData and not ${other.runtimeType}",
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ModelMessageData
        ? const DeepCollectionEquality().equals(this.toJson(), other.toJson())
        : false;
  }

  @override
  int get hashCode => this.toString().hashCode;

  @override
  String toString() => this.toJson().toString();
}
