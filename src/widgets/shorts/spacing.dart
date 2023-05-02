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

Widget wDividerThin([double? height]) {
  return Divider(
    thickness: $2,
    height: height,
    color: G.theme.palette.neutral100,
  );
}

Widget wWideDividerThin([double? height]) {
  return SizedBox(
    height: height ?? $2,
    child: OverflowBox(
      maxWidth: G.appScreen.width,
      child: Divider(thickness: $1, color: G.theme.palette.neutral100),
    ),
  );
}

Widget wDividerThick([double? height]) {
  return Divider(
    thickness: $4,
    height: height,
    color: G.theme.palette.neutral100,
  );
}

Widget wWideDividerThick([double? height]) {
  return SizedBox(
    height: height ?? $4,
    child: OverflowBox(
      maxWidth: G.appScreen.width,
      child: Divider(thickness: $4, color: G.theme.palette.neutral100),
    ),
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Widget wScreenPadding32(Widget child) {
  return Padding(
    padding: EdgeInsets.only(
      top: $32,
      left: $32,
      right: $32,
      bottom: $120,
    ),
    child: child,
  );
}

Widget wScreenPadding44(Widget child) {
  return Padding(
    padding: EdgeInsets.only(
      top: $44,
      left: $32,
      right: $32,
      bottom: $120,
    ),
    child: child,
  );
}
