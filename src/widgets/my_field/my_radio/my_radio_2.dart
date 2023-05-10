// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRadio2 extends StatefulWidget {
  //
  //
  //

  final MakeupRadio? makeup;
  final Pod<bool> pValue;
  final Pod<bool>? pEnabled;
  final Pod<String?>? pErrorText;
  final List<Widget> children;
  final void Function(bool)? onTap;

  //
  //
  //

  const MyRadio2({
    Key? key,
    this.makeup,
    required this.pValue,
    this.pEnabled,
    this.pErrorText,
    this.children = const [],
    this.onTap,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyRadio2> {
  //
  //
  //

  @override
  void dispose() {
    this.widget.pEnabled?.disposeIfRequested();
    this.widget.pErrorText?.disposeIfRequested();
    this.widget.pValue?.disposeIfRequested();
    super.dispose();
  }

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.widget.makeup ?? G.theme.radioDefault();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (this.widget.pEnabled?.valueAs() != false) {
          final a = !this.widget.pValue.valueAs();
          this.widget.pValue.set(a);
          this.widget.onTap?.call(a);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (makeup.isChildrenBefore) ...[
            ...this.widget.children,
            makeup.spacer,
          ],
          SizedBox.square(
            dimension: makeup.size,
            child: Consumer(
              builder: (_, final ref, __) {
                final value = this.widget.pValue.watch(ref);
                final enabled = this.widget.pEnabled?.watch(ref) != false;
                final errorText = this.widget.pErrorText?.watch(ref);
                final error = errorText != null;
                return MyRadio1(
                  value: value,
                  makeup: makeup,
                  enabled: enabled,
                  error: error,
                );
              },
            ),
          ),
          if (makeup.isChildrenAfter) ...[
            makeup.spacer,
            ...this.widget.children,
          ],
        ],
      ),
    );
  }
}
