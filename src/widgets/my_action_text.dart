// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '/all.dart';
import 'expanded_gesture_detector.dart';
import 'my_global_overlay.dart';

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

extension TextWithOnTap on Text {
  Size getCalculatedSize() {
    final textPainter = TextPainter(
      text: TextSpan(text: this.data, style: this.style),
      maxLines: this.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Widget withOnTap(void Function() onTap) {
    return ExpandedTapDetector(
      detectionBorder: Size.square($16),
      onTap: onTap,
      child: this,
    );
  }

  Widget withOnFutureTap(Future<void> Function() onTap) {
    var isLoading = false;
    return MyStatefulBuilder(
      builder: (_, final state) {
        return ExpandedTapDetector(
          detectionBorder: Size.square($16),
          onTap: () async {
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
