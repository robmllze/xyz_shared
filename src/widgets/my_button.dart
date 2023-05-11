// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async' show Completer, FutureOr;

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "color": "Color",
    "defaultWidth": "double?",
    "defaultHeight": "double?",
    "shadow": "BoxShadow?",
    "shape": "RoundedRectangleBorder",
    "textStyle": "TextStyle",
    "padding": "EdgeInsets",
    "loaderMakeup": "MakeupLoader",
    "disabledMakeup": "MakeupButton?",
  },
)
class MyButton extends StatefulWidget {
  //
  //
  //

  final MakeupButton? makeup;
  final String label;
  final bool expanded;
  final Widget? left, right;
  final FutureOr<void> Function()? onTap;
  final _FLoadingBuilder? loadingBuilder;
  final Pod<bool>? pEnabled;

  //
  //
  //

  factory MyButton({
    Key? key,
    MakeupButton? makeup,
    String label = "MyButton",
    bool expanded = false,
    Widget? left,
    Widget? right,
    FutureOr<void> Function()? onTap,
    Pod<bool>? pEnabled,
  }) {
    return MyButton.loading(
      key: key,
      makeup: makeup,
      label: label,
      expanded: expanded,
      left: left,
      right: right,
      onTap: onTap,
      loadingBuilder: (Widget child, _) => child,
      pEnabled: pEnabled,
    );
  }

  //
  //
  //

  const MyButton.loading({
    Key? key,
    this.makeup,
    required this.label,
    this.expanded = false,
    this.left,
    this.right,
    this.onTap,
    this.loadingBuilder,
    this.pEnabled,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyButton> {
  //
  //
  //

  final _pLoadingBuilder = Pod<_FLoadingBuilder?>(null);
  Completer<void>? _loadingCompleter;
  late final _pEnabled = this.widget.pEnabled;
  late final _loadingBuilder = this.widget.loadingBuilder
      // Default.
      ??
      (final child, final makeup) {
        final loaderMakeup = makeup.loaderMakeup;
        final fontSize = makeup.textStyle.fontSize ?? $12;
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (this.widget.expanded) SizedBox(width: 1.5 * fontSize),
            child,
            SizedBox(width: 0.5 * fontSize),
            MyLoader(
              makeup: loaderMakeup.copyWith(
                size: fontSize,
                strokeWidth: 0.16 * fontSize,
              ),
            ),
          ],
        );
      };

  //
  //
  //

  @override
  Widget build(_) {
    final enabledMakeup = this.widget.makeup ?? G.theme.buttonDefault();
    return Consumer(
      builder: (_, final ref, __) {
        final enabled = this._pEnabled?.watch(ref) ?? true;
        final makeup = enabled ? enabledMakeup : enabledMakeup.disabledMakeup ?? enabledMakeup;
        final color = makeup.color;
        final shadow = makeup.shadow;
        final borderRadius = makeup.shape.borderRadius;
        final border = Border.fromBorderSide(makeup.shape.side);
        final padding = makeup.padding;
        return GestureDetector(
          onTap: enabled ? this._load : null,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: shadow != null ? [shadow] : null,
              border: border,
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: padding,
              child: SizedBox(
                width: widget.expanded ? double.infinity : makeup.defaultWidth,
                height: makeup.defaultHeight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Center(
                    child: Consumer(
                      builder: (_, final ref, __) {
                        final child = Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (this.widget.left != null) this.widget.left!,
                            Text(
                              this.widget.label,
                              style: makeup.textStyle,
                            ),
                            if (this.widget.right != null) this.widget.right!,
                          ],
                        );
                        return this._pLoadingBuilder.watch(ref)?.call(child, makeup) ?? child;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //
  //
  //

  Future<void> _load() async {
    this._loadingCompleter = Completer();
    final onTap = this.widget.onTap;
    if (onTap != null) {
      await this._pLoadingBuilder.set(this._loadingBuilder, delay: Duration.zero);
      await onTap();
      await this._pLoadingBuilder.set(null, delay: Duration.zero);
    }
    this._loadingCompleter!.complete();
  }

  //
  //
  //

  @override
  void dispose() {
    this._pEnabled?.disposeIfRequested();
    () async {
      await this._loadingCompleter?.future;
      this._pLoadingBuilder.dispose();
    };
    super.dispose();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef _FLoadingBuilder = Widget Function(Widget child, MakeupButton makeup)?;
