// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRadio2 extends StatefulWidget {
  //
  //
  //

  final MakeupRadio makeup;
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
    required this.makeup,
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
  Widget build(_) {
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
          if (this.widget.makeup.isChildrenBefore) ...[
            ...this.widget.children,
            this.widget.makeup.spacer,
          ],
          SizedBox.square(
            dimension: this.widget.makeup.size,
            child: Consumer(
              builder: (_, final ref, __) {
                final value = this.widget.pValue.watch(ref);
                final enabled = this.widget.pEnabled?.watch(ref) != false;
                final errorText = this.widget.pErrorText?.watch(ref);
                final error = errorText != null;
                return MyRadio1(
                  value: value,
                  makeup: this.widget.makeup,
                  enabled: enabled,
                  error: error,
                );
              },
            ),
          ),
          if (this.widget.makeup.isChildrenAfter) ...[
            this.widget.makeup.spacer,
            ...this.widget.children,
          ],
        ],
      ),
    );
  }
}
