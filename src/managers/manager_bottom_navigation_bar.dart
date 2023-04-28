
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Wickd.ly
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Manager_BottomNavigationBar {
  //
  //
  //

  final Widget widget;

  late final Pod<Widget?> pValue;

  Manager_BottomNavigationBar(this.widget) {
    pValue = Pod<Widget?>(this.widget);
  }

  //
  //
  //

  bool isVisible() => pValue.valueAs() == null;

  //
  //
  //

  Future<void> show() async {
    if (!this.isVisible()) {
      await pValue.set(widget);
    }
  }

  //
  //
  //

  Future<void> hide() async {
    if (this.isVisible()) {
      await pValue.set(null);
    }
  }

  //
  //
  //

  Future<bool> toggle() async {
    final visible = this.isVisible();
    await pValue.set(
      visible ? widget : null,
    );
    return !visible;
  }
}
