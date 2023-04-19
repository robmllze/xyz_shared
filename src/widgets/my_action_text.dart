// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyActionText extends StatelessWidget {
  //
  //
  //

  final Text text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  //
  //
  //

  const MyActionText({
    Key? key,
    required this.text,
    this.onPressed,
    this.padding,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: text,
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension MyActionTextExtension on Text {
  /// Adds an action to a Text widget that triggers when tapped.
  Widget action({
    void Function()? onPressed,
    EdgeInsetsGeometry? padding,
  }) {
    return MyActionText(
      text: this,
      onPressed: onPressed,
      padding: padding,
    );
  }
}
