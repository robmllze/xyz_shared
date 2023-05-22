// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: must_be_immutable

import '/all.dart';

import 'dart:async';

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "overlayColor": "Color",
    "closeIconBackroundColor": "Color",
    "closeIconForegroundColor": "Color",
    "decoration": "BoxDecoration",
    "messageTextStyle": "TextStyle",
    "titleTextStyle": "TextStyle",
  },
)
abstract class MyDialog extends StatefulWidget {
  //
  //
  //

  final completer = Completer<void>();
  Future<void> Function(Object? e)? onError;
  final bool shouldCloseOnComplete;

  //
  //
  //

  MyDialog({
    required Key? key,
    required this.onError,
    required this.shouldCloseOnComplete,
  }) : super(key: key);
}
