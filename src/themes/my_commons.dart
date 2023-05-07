// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final commons = MyCommons();

class MyCommons {
  //
  //
  //

  static final instance = MyCommons._();
  MyCommons._();
  factory MyCommons() => instance;

  //
  //
  //

  // BUTTONS, TEXT FIELDS, CONTAINERS

  Radius radius4() => Radius.circular($4);
  Radius radius16() => Radius.circular($16);
  BorderRadius borderRadius4() => BorderRadius.all(radius4());
  BorderRadius borderRadius16() => BorderRadius.all(radius16());
  double borderThickness1() => $1;
  BorderSide borderSide1(Color color) => BorderSide(color: color, width: borderThickness1());
  Border border1(Color color) => Border.fromBorderSide(borderSide1(color));
  RoundedRectangleBorder outlineBorder({required Color outlineColor}) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius4(),
      side: borderSide1(outlineColor),
    );
  }

  BoxDecoration borderBoxDecoration({
    Color? fillColor,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: fillColor,
      borderRadius: borderRadius4(),
      boxShadow: boxShadow,
      border: borderColor != null ? border1(borderColor) : null,
    );
  }

  BoxDecoration copyWithBorderColor(BoxDecoration decoration, Color color, {double? thickness}) {
    return decoration.copyWith(border: Border.all(width: thickness ?? $1, color: color));
  }

  EdgeInsets edgeInsets4() => EdgeInsets.all($4);
  EdgeInsets innerButtonEdgeInsets() => EdgeInsets.symmetric(horizontal: $16, vertical: $12);

  List<BoxShadow> outlineBoxShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: $1,
        blurRadius: 4.0.scaled,
      )
    ];
  }

  //
  //
  //

  // LAYOUTS
}
