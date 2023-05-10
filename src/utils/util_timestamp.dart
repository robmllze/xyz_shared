// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

DateTime? getLastDate(Iterable<DateTime>? dates) {
  return dates?.reduce(
    (final a, final b) {
      return a.microsecondsSinceEpoch > b.microsecondsSinceEpoch ? a : b;
    },
  );
}

DateTime? getFirstDate(Iterable<DateTime>? dates) {
  return dates?.reduce(
    (final a, final b) {
      return a.microsecondsSinceEpoch < b.microsecondsSinceEpoch ? a : b;
    },
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Timestamp? letTimestamp(dynamic input) {
  if (input == null) return null;
  if (input is Timestamp) return input;
  if (input is String) {
    final a = int.tryParse(input);
    if (a != null) return Timestamp.fromMicrosecondsSinceEpoch(a);
  }
  if (input is DateTime) return Timestamp.fromDate(input);
  switch (input.runtimeType) {
    case int:
      return Timestamp.fromMicrosecondsSinceEpoch(input);
    case double:
      return Timestamp.fromMicrosecondsSinceEpoch((input as double).round());
  }
  if (input is Duration) return Timestamp.fromMicrosecondsSinceEpoch(input.inMicroseconds);

  return null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String? timestampKeyConverter(dynamic key) {
  if (key is Timestamp) {
    return key.microsecondsSinceEpoch.toString();
  }
  return null;
}
