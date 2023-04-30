// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_event_data.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

class ModelEventData extends ModelEventDataUtils {
  //
  //
  //

  /// Related member: `this.id`;
  static const K_ID = "id";

  /// Related member: `this.args`;
  static const K_ARGS = "args";

  /// Key corresponding to the value `body`.
  static const K_BODY = "body";

  /// Value corresponding to the key `body` or [K_BODY].
  Map<String, dynamic>? body;

  /// Key corresponding to the value `dateSent`.
  static const K_DATE_SENT = "date_sent";

  /// Value corresponding to the key `date_sent` or [K_DATE_SENT].
  DateTime? dateSent;

  /// Key corresponding to the value `eventsPath`.
  static const K_EVENTS_PATH = "events_path";

  /// Value corresponding to the key `events_path` or [K_EVENTS_PATH].
  String? eventsPath;

  /// Key corresponding to the value `isArchived`.
  static const K_IS_ARCHIVED = "is_archived";

  /// Value corresponding to the key `is_archived` or [K_IS_ARCHIVED].
  bool? isArchived;

  /// Key corresponding to the value `isDelivered`.
  static const K_IS_DELIVERED = "is_delivered";

  /// Value corresponding to the key `is_delivered` or [K_IS_DELIVERED].
  bool? isDelivered;

  /// Key corresponding to the value `isHidden`.
  static const K_IS_HIDDEN = "is_hidden";

  /// Value corresponding to the key `is_hidden` or [K_IS_HIDDEN].
  bool? isHidden;

  /// Key corresponding to the value `isLiked`.
  static const K_IS_LIKED = "is_liked";

  /// Value corresponding to the key `is_liked` or [K_IS_LIKED].
  bool? isLiked;

  /// Key corresponding to the value `isRead`.
  static const K_IS_READ = "is_read";

  /// Value corresponding to the key `is_read` or [K_IS_READ].
  bool? isRead;

  /// Key corresponding to the value `isSent`.
  static const K_IS_SENT = "is_sent";

  /// Value corresponding to the key `is_sent` or [K_IS_SENT].
  bool? isSent;

  /// Key corresponding to the value `lifespan`.
  static const K_LIFESPAN = "lifespan";

  /// Value corresponding to the key `lifespan` or [K_LIFESPAN].
  Duration? lifespan;

  /// Key corresponding to the value `receiver`.
  static const K_RECEIVER = "receiver";

  /// Value corresponding to the key `receiver` or [K_RECEIVER].
  ModelUserData? receiver;

  /// Key corresponding to the value `sender`.
  static const K_SENDER = "sender";

  /// Value corresponding to the key `sender` or [K_SENDER].
  ModelUserData? sender;

  /// Key corresponding to the value `timesDelivered`.
  static const K_TIMES_DELIVERED = "times_delivered";

  /// Value corresponding to the key `times_delivered` or [K_TIMES_DELIVERED].
  Map<String, Timestamp>? timesDelivered;

  /// Key corresponding to the value `timesRead`.
  static const K_TIMES_READ = "times_read";

  /// Value corresponding to the key `times_read` or [K_TIMES_READ].
  Map<String, Timestamp>? timesRead;

  /// Key corresponding to the value `typeCode`.
  static const K_TYPE_CODE = "type_code";

  /// Value corresponding to the key `type_code` or [K_TYPE_CODE].
  String? typeCode;

  //
  //
  //

  /// Constructs a new instance of [ModelEventData] identified by [id].
  ModelEventData({
    String? id,
    dynamic args,
    this.body,
    this.dateSent,
    this.eventsPath,
    this.isArchived,
    this.isDelivered,
    this.isHidden,
    this.isLiked,
    this.isRead,
    this.isSent,
    this.lifespan,
    this.receiver,
    this.sender,
    this.timesDelivered,
    this.timesRead,
    this.typeCode,
  }) : super._() {
    super.id = id;
    super.args = args;
  }

  /// Converts a [Json] object to a [ModelEventData] object.
  factory ModelEventData.fromJson(Json json) {
    try {
      return ModelEventData(
        args: json[K_ARGS],
        body: letAs<Map>(json[K_BODY])
            ?.map(
              (final p0, final p1) => MapEntry(
                (p0?.toString()),
                p1,
              ),
            )
            .nullsRemoved()
            .nullIfEmpty(),
        dateSent: (json[K_DATE_SENT] as Timestamp?)?.toDate(),
        eventsPath: (json[K_EVENTS_PATH]?.toString()),
        id: (json[K_ID]?.toString()),
        isArchived: letAs<bool>(json[K_IS_ARCHIVED]),
        isDelivered: letAs<bool>(json[K_IS_DELIVERED]),
        isHidden: letAs<bool>(json[K_IS_HIDDEN]),
        isLiked: letAs<bool>(json[K_IS_LIKED]),
        isRead: letAs<bool>(json[K_IS_READ]),
        isSent: letAs<bool>(json[K_IS_SENT]),
        lifespan: () {
          final a = letAs<int>(json[K_LIFESPAN]);
          return a != null ? Duration(microseconds: a) : null;
        }(),
        receiver: () {
          final l = letAs<Map>(json[K_RECEIVER]);
          return l != null
              ? ModelUserData?.fromJson(
                  l.map(
                    (
                      final p0,
                      final p1,
                    ) =>
                        MapEntry(
                      p0.toString(),
                      p1,
                    ),
                  ),
                )
              : null;
        }(),
        sender: () {
          final l = letAs<Map>(json[K_SENDER]);
          return l != null
              ? ModelUserData?.fromJson(
                  l.map(
                    (
                      final p0,
                      final p1,
                    ) =>
                        MapEntry(
                      p0.toString(),
                      p1,
                    ),
                  ),
                )
              : null;
        }(),
        timesDelivered: letAs<Map>(json[K_TIMES_DELIVERED])
            ?.map(
              (final p0, final p1) => MapEntry(
                (p0?.toString()),
                () {
                  final a = letAs<int>(p1);
                  return a != null
                      ? Timestamp.fromMicrosecondsSinceEpoch(a)
                      : null;
                }(),
              ),
            )
            .nullsRemoved()
            .nullIfEmpty(),
        timesRead: letAs<Map>(json[K_TIMES_READ])
            ?.map(
              (final p0, final p1) => MapEntry(
                (p0?.toString()),
                () {
                  final a = letAs<int>(p1);
                  return a != null
                      ? Timestamp.fromMicrosecondsSinceEpoch(a)
                      : null;
                }(),
              ),
            )
            .nullsRemoved()
            .nullIfEmpty(),
        typeCode: (json[K_TYPE_CODE]?.toString()),
      );
    } catch (e) {
      throw Exception(
        "[ModelEventData.fromJson] Failed to convert JSON to ModelEventData due to: $e",
      );
    }
  }

  /// Returns a copy of `this` model.
  @override
  T copy<T extends XyzModel>(T other) {
    return (ModelEventData()..updateWith(other)) as T;
  }

  /// Converts a [ModelEventData] object to a [Json] object.
  @override
  Json toJson() {
    try {
      return mapToJson(
        {
          K_ARGS: args,
          K_BODY: body
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.nullIfEmpty(),
                  p1,
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
          K_DATE_SENT: () {
            final a = dateSent;
            return a != null ? Timestamp.fromDate(a) : null;
          }(),
          K_EVENTS_PATH: eventsPath?.nullIfEmpty(),
          K_ID: id?.nullIfEmpty(),
          K_IS_ARCHIVED: isArchived,
          K_IS_DELIVERED: isDelivered,
          K_IS_HIDDEN: isHidden,
          K_IS_LIKED: isLiked,
          K_IS_READ: isRead,
          K_IS_SENT: isSent,
          K_LIFESPAN: lifespan?.inMicroseconds,
          K_RECEIVER: receiver?.toJson().nullsRemoved().nullIfEmpty(),
          K_SENDER: sender?.toJson().nullsRemoved().nullIfEmpty(),
          K_TIMES_DELIVERED: timesDelivered
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.nullIfEmpty(),
                  p1.microsecondsSinceEpoch,
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
          K_TIMES_READ: timesRead
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.nullIfEmpty(),
                  p1.microsecondsSinceEpoch,
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
          K_TYPE_CODE: typeCode?.nullIfEmpty(),
        }..removeWhere((_, final l) => l == null),
        typesAllowed: {Timestamp, FieldValue},
        // Defined in utils/timestamp.dart
        keyConverter: timestampKeyConverter,
      );
    } catch (e) {
      throw Exception(
        "[ModelEventData.toJson] Failed to convert ModelEventData to JSON due to: $e",
      );
    }
  }

  /// Returns a copy of `this` object with the fields in [other] overriding
  /// `this` fields. NB: [other] must be of type ModelEventData.
  @override
  T newOverride<T extends XyzModel>(T other) {
    if (other is ModelEventData) {
      return ModelEventData(
        args: other.args ?? this.args,
        body: other.body ?? this.body,
        dateSent: other.dateSent ?? this.dateSent,
        eventsPath: other.eventsPath ?? this.eventsPath,
        id: other.id ?? this.id,
        isArchived: other.isArchived ?? this.isArchived,
        isDelivered: other.isDelivered ?? this.isDelivered,
        isHidden: other.isHidden ?? this.isHidden,
        isLiked: other.isLiked ?? this.isLiked,
        isRead: other.isRead ?? this.isRead,
        isSent: other.isSent ?? this.isSent,
        lifespan: other.lifespan ?? this.lifespan,
        receiver: other.receiver ?? this.receiver,
        sender: other.sender ?? this.sender,
        timesDelivered: other.timesDelivered ?? this.timesDelivered,
        timesRead: other.timesRead ?? this.timesRead,
        typeCode: other.typeCode ?? this.typeCode,
      ) as T;
    }
    throw Exception(
      "[ModelEventData.newOverride] Expected 'other' to be of type ModelEventData and not ${other.runtimeType}",
    );
  }

  /// Returns a new empty instance of [ModelEventData].
  @override
  T newEmpty<T extends XyzModel>() {
    return ModelEventData() as T;
  }

  /// Updates `this` fields from the fields of [other].
  @override
  void updateWithJson(Json other) {
    this.updateWith(ModelEventData.fromJson(other));
  }

  /// Updates `this` fields from the fields of [other].
  @override
  void updateWith<T extends XyzModel>(T other) {
    if (other is ModelEventData) {
      if (other.args != null) {
        this.args = other.args;
      }
      if (other.body != null) {
        this.body = other.body;
      }
      if (other.dateSent != null) {
        this.dateSent = other.dateSent;
      }
      if (other.eventsPath != null) {
        this.eventsPath = other.eventsPath;
      }
      if (other.id != null) {
        this.id = other.id;
      }
      if (other.isArchived != null) {
        this.isArchived = other.isArchived;
      }
      if (other.isDelivered != null) {
        this.isDelivered = other.isDelivered;
      }
      if (other.isHidden != null) {
        this.isHidden = other.isHidden;
      }
      if (other.isLiked != null) {
        this.isLiked = other.isLiked;
      }
      if (other.isRead != null) {
        this.isRead = other.isRead;
      }
      if (other.isSent != null) {
        this.isSent = other.isSent;
      }
      if (other.lifespan != null) {
        this.lifespan = other.lifespan;
      }
      if (other.receiver != null) {
        this.receiver = other.receiver;
      }
      if (other.sender != null) {
        this.sender = other.sender;
      }
      if (other.timesDelivered != null) {
        this.timesDelivered = other.timesDelivered;
      }
      if (other.timesRead != null) {
        this.timesRead = other.timesRead;
      }
      if (other.typeCode != null) {
        this.typeCode = other.typeCode;
      }
      return;
    }
    throw Exception(
      "[ModelEventData.updateWith] Expected 'other' to be of type ModelEventData and not ${other.runtimeType}",
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ModelEventData
        ? const DeepCollectionEquality().equals(this.toJson(), other.toJson())
        : false;
  }

  @override
  int get hashCode => this.toString().hashCode;

  @override
  String toString() => this.toJson().toString();
}
