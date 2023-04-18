// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// NOTE: For each function you add here, also add a function with the same name
// and parameters in '_platform_compatibility_web.dart' and
// '_platform_compatibility_none.dart'
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:ui' as ui;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// ...
void hOpen() {
  throw UnimplementedError();
}

/// ...
void hPushState(String? location) {
  // Do nothing.
}

/// ...
void hDownloadBytes(List<int> bytes, String? output) {
  throw UnimplementedError();
}

/// ...
void hDownloadFile(String url) {
  throw UnimplementedError();
}

// ...
void hDisablePop() {
  // Do nothing.
}

/// ...
void hRegisterWebViewWebImplementation() {
  // Do nothing.
}

/// ...
bool isAppInstalled() {
  return true;
}

/// ...
void Function() hOnKeyUp(bool Function(int keyCode) handler) {
  ui.window.onKeyData = (final data) {
    if (data.type == ui.KeyEventType.up) {
      return handler(data.logical);
    }
    return false;
  };
  return () => ui.window.onKeyData = null;
}

/// ...
void Function() hOnKeyDown(bool Function(int keyCode) handler) {
  ui.window.onKeyData = (final data) {
    if (data.type == ui.KeyEventType.down) {
      return handler(data.logical);
    }
    return false;
  };
  return () => ui.window.onKeyData = null;
}

/// ...
void Function() hOnKeyRepeat(bool Function(int keyCode) handler) {
  ui.window.onKeyData = (final data) {
    if (data.type == ui.KeyEventType.repeat) {
      return handler(data.logical);
    }
    return false;
  };
  return () => ui.window.onKeyData = null;
}
