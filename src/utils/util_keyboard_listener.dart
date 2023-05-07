// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyKeyboardListener {
  //
  //
  //

  final void Function()? onShow, onHide;
  Timer? _timer;
  bool _calledOnShow = false, _calledOnHide = false;

  //
  //
  //

  MyKeyboardListener({
    this.onShow,
    this.onHide,
  });

  //
  //
  //

  void listenStart() {
    this._timer = Timer.periodic(Duration.zero, (_) {
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
        if (this._calledOnShow == false) {
          this.onShow?.call();
          this._calledOnShow = true;
          this._calledOnHide = false;
        }
      } else {
        if (this._calledOnHide == false) {
          this.onHide?.call();
          this._calledOnHide = true;
          this._calledOnShow = false;
        }
      }
    });
  }

  //
  //
  //

  void listenStop() {
    this._timer?.cancel();
    this._timer = null;
  }
}
