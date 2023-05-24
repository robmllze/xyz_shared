// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ToTappableText on Text {
  //
  //
  //

  Size getSize() {
    final textPainter = TextPainter(
      text: TextSpan(text: this.data, style: this.style),
      maxLines: this.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  //
  //
  //

  Widget toTappableText(
    void Function() onTap, [
    Size? detectionBorder,
  ]) {
    return MyTapDetector(
      detectionBorder: detectionBorder ?? Size.square($16),
      onTap: onTap,
      child: this,
    );
  }

  //
  //
  //

  Widget toTappableTextAsync(
    Future<void> Function() onTap, [
    Size? detectionBorder,
  ]) {
    var isLoading = false;
    return MyStatefulBuilder(
      builder: (_, final state) {
        return MyTapDetector(
          detectionBorder: detectionBorder ?? Size.square($16),
          onTap: isLoading
              ? null
              : () async {
                  state.refresh(() {
                    isLoading = true;
                  });
                  await onTap();
                  state.refresh(() {
                    isLoading = false;
                  });
                },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              this,
              if (isLoading) Text("...", style: this.style),
            ],
          ),
        );
      },
    );
  }
}
