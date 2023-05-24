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
  final TextStyle? defaultStyle;
  final Map<String, TextStyle> styles;
  final Map<String, Widget> widgets;
  final Map<String, VoidCallback> callbacks;
  final TextAlign textAlign;
  final bool softWrap;

  const MyInlineText(
    this.text, {
    Key? key,
    this.defaultStyle,
    this.styles = const {},
    this.widgets = const {},
    this.callbacks = const {},
    this.textAlign = TextAlign.center,
    this.softWrap = true,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final segments = text.split(RegExp(r"(?<=\}\})|(?=\{\{)"));
    final spans = <InlineSpan>[];
    final defaultStyle1 = this.defaultStyle ?? styles.values.tryFirst;

    for (final segment in segments) {
      if (segment.startsWith("{{") && segment.endsWith("}}")) {
        final data = segment.substring(2, segment.length - 2);
        final parts = data.split(":");
        final length = parts.length;
        final key = parts.tryFirst;
        final widget = widgets[key];
        final style = styles[key] ?? defaultStyle1;
        final callback = callbacks[key];
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
              style: defaultStyle1,
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
