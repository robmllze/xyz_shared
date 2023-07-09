// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:ui' as ui;

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyFacade {
  final ui.Image? image;
  final double blurStrength;
  final Color blurColor;
  final Widget? child;

  const MyFacade({
    this.image,
    this.child,
    this.blurStrength = 2.5,
    this.blurColor = Colors.transparent,
  });

  MyFacade copyWith({
    ui.Image? image,
    double? blurStrength,
    Color? blurColor,
    Widget? child,
  }) {
    return MyFacade(
      image: image ?? this.image,
      blurStrength: blurStrength ?? this.blurStrength,
      blurColor: blurColor ?? this.blurColor,
      child: child ?? this.child,
    );
  }

  Widget draw() {
    return Blur(
      blur: blurStrength,
      blurColor: blurColor,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          RawImage(
            fit: BoxFit.fill,
            image: image,
          ),
          if (child != null) child!
        ],
      ),
    );
  }
}
