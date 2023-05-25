// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import "package:flutter/material.dart";

import "/all.dart";

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyInlineText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Map<String, TextStyle> namedStyles;
  final Map<String, Widget> namedWidgets;
  final Map<String, VoidCallback> namedCallbacks;
  final TextAlign textAlign;
  final bool softWrap;

  const MyInlineText(
    this.text, {
    Key? key,
    this.style,
    this.namedStyles = const {},
    this.namedWidgets = const {},
    this.namedCallbacks = const {},
    this.textAlign = TextAlign.left,
    this.softWrap = true,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final segments = text.split(RegExp(r"(?<=\}\})|(?=\{\{)"));
    final spans = <InlineSpan>[];

    for (final segment in segments) {
      if (segment.startsWith("{{") && segment.endsWith("}}")) {
        final data = segment.substring(2, segment.length - 2);
        final parts = data.split(":");
        final length = parts.length;
        final key = parts.tryFirst;
        final widget = namedWidgets[key];
        final style = namedStyles[key] ?? namedStyles.values.tryFirst ?? this.style;
        final callback = namedCallbacks[key];
        if (widget != null) {
          spans.add(
            WidgetSpan(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: callback,
                child: widget,
              ),
            ),
          );
        } else {
          final text = length == 2 ? parts[1] : data;
          spans.add(
            WidgetSpan(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: callback,
                child: Text(
                  text,
                  style: style,
                  textAlign: this.textAlign,
                  softWrap: this.softWrap,
                ),
              ),
            ),
          );
        }
      } else {
        final data = segment.replaceAll(r"\{", "{").replaceAll(r"\}", "}");
        spans.add(
          WidgetSpan(
            child: Text(
              data,
              style: this.style ?? namedStyles.values.tryFirst,
              textAlign: this.textAlign,
              softWrap: this.softWrap,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(children: spans),
      textAlign: this.textAlign,
      softWrap: this.softWrap,
    );
  }
}
