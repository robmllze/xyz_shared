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

class MyHeaderBar extends StatelessWidget {
  //
  //
  //

  final MakeupHeader makeup;
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
    return Container(
      color: this.makeup.makeupScreen.backgroundColor,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: this.makeup.minHeight),
        decoration: this.makeup.decoration,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (this.child != null) this.child!,
            if (this.title != null) this.title!,
          ],
        ),
      ),
    );
  }
}
