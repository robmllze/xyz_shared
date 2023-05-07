// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyButtonCircle extends StatelessWidget {
  //
  //
  //

  final Widget child;
  final void Function()? onTap;
  final Color color;

  //
  //
  //

  const MyButtonCircle({
    Key? key,
    this.onTap,
    required this.color,
    required this.child,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return GestureDetector(
      onTap: this.onTap,
      child: Opacity(
        opacity: this.onTap != null ? 1.0 : 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: this.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 6.0.scaled,
                offset: Offset(
                  0.0,
                  4.0.scaled,
                ),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: this.child,
        ),
      ),
    );
  }
}
