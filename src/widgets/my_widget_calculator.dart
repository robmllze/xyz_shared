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

class MyWidgetCalculator extends StatefulWidget {
  //
  //
  //

  final Widget? child;
  final void Function(RenderBox renderBox)? onPostRender;
  final Pod<RenderBox?>? pRenderBox;

  //
  //
  //

  const MyWidgetCalculator({
    super.key,
    this.child,
    this.pRenderBox,
    this.onPostRender,
  });

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyWidgetCalculator> {
  //
  //
  //

  final _key = GlobalKey();

  //
  //
  //

  @override
  void initState() {
    super.initState();
    // Wait for the layout to finish before measuring the size.
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final renderBox = this._key.currentContext!.findRenderObject() as RenderBox;
      this.widget.pRenderBox?.set(renderBox);
      this.widget.onPostRender?.call(renderBox);
    });
  }

  //
  //
  //

  @override
  Widget build(_) {
    return LayoutBuilder(
      builder: (_, final constraints) {
        return SizedBox(
          key: this._key,
          child: this.widget.child,
        );
      },
    );
  }
}
