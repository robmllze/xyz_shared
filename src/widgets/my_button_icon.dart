// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyButtonIcon extends StatelessWidget {
  //
  //
  //

  final Widget icon;
  final void Function()? onTap;
  final double padding;

  //
  //
  //

  const MyButtonIcon({
    Key? key,
    required this.icon,
    this.onTap,
    this.padding = -10.0,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return GestureDetector(
      onTapDown: this.onTap != null ? (_) => this.onTap?.call() : null,
      child: Padding(
        padding: EdgeInsets.all(this.padding < 0 ? (-this.padding).scaled : this.padding),
        child: Opacity(
          opacity: this.onTap != null ? 1.0 : 0.5,
          child: SizedBox.square(
            child: this.icon,
          ),
        ),
      ),
    );
  }
}
