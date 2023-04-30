// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_events.dart';

// **************************************************************************
// ModelGenerator
// **************************************************************************

class ModelEvents extends ModelEventsUtils {
  //
  //
  //

  /// Related member: `this.id`;
  static const K_ID = "id";

  /// Related member: `this.args`;
  static const K_ARGS = "args";

  /// Key corresponding to the value `collection`.
  static const K_COLLECTION = "collection";

  /// Value corresponding to the key `collection` or [K_COLLECTION].
  String? collection;

  /// Key corresponding to the value `idsParticipants`.
  static const K_IDS_PARTICIPANTS = "ids_participants";

  /// Value corresponding to the key `ids_participants` or [K_IDS_PARTICIPANTS].
  Set<String>? idsParticipants;

  /// Key corresponding to the value `keysUnread`.
  static const K_KEYS_UNREAD = "keys_unread";

  /// Value corresponding to the key `keys_unread` or [K_KEYS_UNREAD].
  Map<String, Set<Timestamp>>? keysUnread;

  /// Key corresponding to the value `keys`.
  static const K_KEYS = "keys";

  /// Value corresponding to the key `keys` or [K_KEYS].
  Set<Timestamp>? keys;

  /// Key corresponding to the value `partTotal`.
  static const K_PART_TOTAL = "part_total";

  /// Value corresponding to the key `part_total` or [K_PART_TOTAL].
  int? partTotal;

  /// Key corresponding to the value `registry`.
  static const K_REGISTRY = "registry";

  /// Value corresponding to the key `registry` or [K_REGISTRY].
  Map<Timestamp, ModelEventData>? registry;

  /// Key corresponding to the value `timesLastDelivered`.
  static const K_TIMES_LAST_DELIVERED = "times_last_delivered";

  /// Value corresponding to the key `times_last_delivered` or [K_TIMES_LAST_DELIVERED].
  Map<String, Timestamp>? timesLastDelivered;

  /// Key corresponding to the value `timesLastRead`.
  static const K_TIMES_LAST_READ = "times_last_read";

  /// Value corresponding to the key `times_last_read` or [K_TIMES_LAST_READ].
  Map<String, Timestamp>? timesLastRead;

  //
  //
  //

  /// Constructs a new instance of [ModelEvents] identified by [id].
  ModelEvents({
    String? id,
    dynamic args,
    this.collection,
    this.idsParticipants,
    this.keys,
    this.keysUnread,
    this.partTotal,
    this.registry,
    this.timesLastDelivered,
    this.timesLastRead,
  }) : super._() {
    super.id = id;
    super.args = args;
  }

  /// Converts a [Json] object to a [ModelEvents] object.
  factory ModelEvents.fromJson(Json json) {
    try {
      return ModelEvents(
        args: json[K_ARGS],
        collection: (json[K_COLLECTION]?.toString()),
        id: (json[K_ID]?.toString()),
        idsParticipants: letAs<List>(json[K_IDS_PARTICIPANTS])
            ?.map(
              (final p0) => (p0?.toString()),
            )
            .nullsRemoved()
            .nullIfEmpty()
            ?.toSet(),
        keys: letAs<List>(json[K_KEYS])
            ?.map(
              (final p0) => () {
                final a = letAs<int>(p0);
                return a != null
                    ? Timestamp.fromMicrosecondsSinceEpoch(a)
                    : null;
              }(),
            )
            .nullsRemoved()
            .nullIfEmpty()
            ?.toSet(),
        keysUnread: letAs<Map>(json[K_KEYS_UNREAD])
            ?.map(
              (final p0, final p1) => MapEntry(
                (p0?.toString()),
                letAs<List>(p1)
                    ?.map(
                      (final p0) => () {
                        final a = letAs<int>(p0);
                        return a != null
                            ? Timestamp.fromMicrosecondsSinceEpoch(a)
                            : null;
                      }(),
                    )
                    .nullsRemoved()
                    .nullIfEmpty()
                    ?.toSet(),
              ),
            )
            .nullsRemoved()
            .nullIfEmpty(),
        partTotal: letInt(json[K_PART_TOTAL]),
        registry: letAs<Map>(json[K_REGISTRY])
            ?.map(
              (final p0, final p1) => MapEntry(
                () {
                  final a = letInt(p0);
                  return a != null
                      ? Timestamp.fromMicrosecondsSinceEpoch(a)
                      : null;
                }(),
                () {
                  final l = letAs<Map>(p1);
                  return l != null
                      ? ModelEventData?.fromJson(
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
              ),
            )
            .nullsRemoved()
            .nullIfEmpty(),
        timesLastDelivered: letAs<Map>(json[K_TIMES_LAST_DELIVERED])
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
        timesLastRead: letAs<Map>(json[K_TIMES_LAST_READ])
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
      );
    } catch (e) {
      throw Exception(
        "[ModelEvents.fromJson] Failed to convert JSON to ModelEvents due to: $e",
      );
    }
  }

  /// Returns a copy of `this` model.
  @override
  T copy<T extends XyzModel>(T other) {
    return (ModelEvents()..updateWith(other)) as T;
  }

  /// Converts a [ModelEvents] object to a [Json] object.
  @override
  Json toJson() {
    try {
      return mapToJson(
        {
          K_ARGS: args,
          K_COLLECTION: collection?.nullIfEmpty(),
          K_ID: id?.nullIfEmpty(),
          K_IDS_PARTICIPANTS: idsParticipants
              ?.map(
                (final p0) => p0.nullIfEmpty(),
              )
              .nullsRemoved()
              .nullIfEmpty()
              ?.toList(),
          K_KEYS: keys
              ?.map(
                (final p0) => p0.microsecondsSinceEpoch,
              )
              .nullsRemoved()
              .nullIfEmpty()
              ?.toList(),
          K_KEYS_UNREAD: keysUnread
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.nullIfEmpty(),
                  p1
                      .map(
                        (final p0) => p0.microsecondsSinceEpoch,
                      )
                      .nullsRemoved()
                      .nullIfEmpty()
                      ?.toList(),
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
          K_PART_TOTAL: partTotal,
          K_REGISTRY: registry
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.microsecondsSinceEpoch,
                  p1.toJson().nullsRemoved().nullIfEmpty(),
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
          K_TIMES_LAST_DELIVERED: timesLastDelivered
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.nullIfEmpty(),
                  p1.microsecondsSinceEpoch,
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
          K_TIMES_LAST_READ: timesLastRead
              ?.map(
                (final p0, final p1) => MapEntry(
                  p0.nullIfEmpty(),
                  p1.microsecondsSinceEpoch,
                ),
              )
              .nullsRemoved()
              .nullIfEmpty(),
        }..removeWhere((_, final l) => l == null),
        typesAllowed: {Timestamp, FieldValue},
        // Defined in utils/timestamp.dart
        keyConverter: timestampKeyConverter,
      );
    } catch (e) {
      throw Exception(
        "[ModelEvents.toJson] Failed to convert ModelEvents to JSON due to: $e",
      );
    }
  }

  /// Returns a copy of `this` object with the fields in [other] overriding
  /// `this` fields. NB: [other] must be of type ModelEvents.
  @override
  T newOverride<T extends XyzModel>(T other) {
    if (other is ModelEvents) {
      return ModelEvents(
        args: other.args ?? this.args,
        collection: other.collection ?? this.collection,
        id: other.id ?? this.id,
        idsParticipants: other.idsParticipants ?? this.idsParticipants,
        keys: other.keys ?? this.keys,
        keysUnread: other.keysUnread ?? this.keysUnread,
        partTotal: other.partTotal ?? this.partTotal,
        registry: other.registry ?? this.registry,
        timesLastDelivered: other.timesLastDelivered ?? this.timesLastDelivered,
        timesLastRead: other.timesLastRead ?? this.timesLastRead,
      ) as T;
    }
    throw Exception(
      "[ModelEvents.newOverride] Expected 'other' to be of type ModelEvents and not ${other.runtimeType}",
    );
  }

  /// Returns a new empty instance of [ModelEvents].
  @override
  T newEmpty<T extends XyzModel>() {
    return ModelEvents() as T;
  }

  /// Updates `this` fields from the fields of [other].
  @override
  void updateWithJson(Json other) {
    this.updateWith(ModelEvents.fromJson(other));
  }

  /// Updates `this` fields from the fields of [other].
  @override
  void updateWith<T extends XyzModel>(T other) {
    if (other is ModelEvents) {
      if (other.args != null) {
        this.args = other.args;
      }
      if (other.collection != null) {
        this.collection = other.collection;
      }
      if (other.id != null) {
        this.id = other.id;
      }
      if (other.idsParticipants != null) {
        this.idsParticipants = other.idsParticipants;
      }
      if (other.keys != null) {
        this.keys = other.keys;
      }
      if (other.keysUnread != null) {
        this.keysUnread = other.keysUnread;
      }
      if (other.partTotal != null) {
        this.partTotal = other.partTotal;
      }
      if (other.registry != null) {
        this.registry = other.registry;
      }
      if (other.timesLastDelivered != null) {
        this.timesLastDelivered = other.timesLastDelivered;
      }
      if (other.timesLastRead != null) {
        this.timesLastRead = other.timesLastRead;
      }
      return;
    }
    throw Exception(
      "[ModelEvents.updateWith] Expected 'other' to be of type ModelEvents and not ${other.runtimeType}",
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ModelEvents
        ? const DeepCollectionEquality().equals(this.toJson(), other.toJson())
        : false;
  }

  @override
  int get hashCode => this.toString().hashCode;

  @override
  String toString() => this.toJson().toString();
}
