// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyHeaderBar extends StatelessWidget {
  //
  //
  //

  final MakeupHeader? makeup;
  final Widget? title;
  final Widget? child;

  //
  //
  //

  const MyHeaderBar({
    Key? key,
    required this.makeup,
    this.title,
    this.child,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.makeup ?? G.theme.headerDefault();
    return Container(
      color: makeup.makeupScreen.backgroundColor,
      child: Container(
        constraints: BoxConstraints(minHeight: makeup.minHeight),
        decoration: makeup.decoration,
        child: Stack(
          children: [
            if (this.child != null)
              Align(
                alignment: makeup.titleAlignment,
                child: this.child!,
              ),
            if (this.title != null)
              Align(
                alignment: makeup.childAlighment,
                child: this.title!,
              ),
          ],
        ),
      ),
    );
  }
}
