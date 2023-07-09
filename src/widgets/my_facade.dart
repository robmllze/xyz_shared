// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyFacade {
  final ui.Image? image;
  final double sigma;
  final Widget? child;

  const MyFacade({
    this.image,
    this.child,
    this.sigma = 0.0,
  });

  MyFacade copyWith({
    ui.Image? image,
    double? blurStrength,
    Color? blurColor,
    Widget? child,
  }) {
    return MyFacade(
      image: image ?? this.image,
      sigma: blurStrength ?? this.sigma,
      child: child ?? this.child,
    );
  }

  Widget draw() {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          child: ImageFiltered(
            imageFilter: ui.ImageFilter.blur(
              sigmaX: sigma,
              sigmaY: sigma,
              tileMode: ui.TileMode.clamp,
            ),
            child: RawImage(
              fit: BoxFit.fill,
              image: image,
            ),
          ),
        ),
        if (child != null) child!
      ],
    );
  }
}
