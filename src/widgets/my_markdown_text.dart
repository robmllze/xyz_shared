// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyMarkdownText extends StatelessWidget {
  //
  //
  //

  final String data;
  final TextStyle? style;

  //
  //
  //

  const MyMarkdownText(
    this.data, {
    super.key,
    this.style,
  });

  //
  //
  //

  @override
  Widget build(_) {
    return Markdown(
      data: this.data,
      styleSheet: MarkdownStyleSheet(p: this.style),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      softLineBreak: true,
    );
  }
}
