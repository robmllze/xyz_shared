// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';
import 'dart:ui';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyKeyboardListener {
  //
  //
  //

  final FlutterView _view;
  final void Function()? onShow, onHide;
  Timer? _timer;
  bool _didCallOnShow = false, _didCallOnHide = false;

  //
  //
  //

  MyKeyboardListener({
    FlutterView? view,
    this.onShow,
    this.onHide,
  }) : this._view = view ??
            PlatformDispatcher.instance.views.first; // Or use WidgetsBinding.instance.window

  //
  //
  //

  void listenStart() {
    this._timer = Timer.periodic(Duration.zero, (_) {
      if (this._view.viewInsets.bottom > 0.0) {
        if (this._didCallOnShow == false) {
          this.onShow?.call();
          this._didCallOnShow = true;
          this._didCallOnHide = false;
        }
      } else {
        if (this._didCallOnHide == false) {
          this.onHide?.call();
          this._didCallOnHide = true;
          this._didCallOnShow = false;
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
