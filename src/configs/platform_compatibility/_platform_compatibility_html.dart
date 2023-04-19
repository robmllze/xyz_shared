// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Xyz Shared
//
// This code is copyrighted - See LICENCE.txt
//
// Add web-only functions here.
//
// NOTE: For each function you add here, also add a function with the same name
// and parameters in '_platform_compatibility_io.dart' and
// '_platform_compatibility_none.dart'
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:js' as js;

import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart' show WebViewPlatform;
import 'package:webview_flutter_web/webview_flutter_web.dart' show WebWebViewPlatform;

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// ...
void hOpen() {
  html.window.open((XYZ_APP_URL), "_self");
}

/// ...
void hPushState(String? location) {
  html.window.history.pushState(
    null,
    "",
    location,
  );
}

/// ...
void hDownloadBytes(List<int> bytes, String? output) {
  // Encode our file in base64
  final base64 = base64Encode(bytes);
  // Create the link with the file
  final anchor = html.AnchorElement(
    href: "data:application/octet-stream;base64,$base64",
  )..target = "blank";
  // Add the name
  if (output != null) {
    anchor.download = output;
  }
  // Trigger download
  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}

/// ...
void hDownloadFile(String url) {
  // Create the link with the file
  final anchor = html.AnchorElement(
    href: url,
  )..target = "blank";
  anchor.download = url;
  // Trigger download
  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}

/// ...
void hDisablePop() {
  html.window.addEventListener("popstate", (_) {
    hPushState(null);
  });
}

/// ...
void hRegisterWebViewWebImplementation() {
  WebViewPlatform.instance = WebWebViewPlatform();
}

/// ...
bool isAppInstalled() {
  return js.context.callMethod("isPwaInstalled");
}

/// ...
void Function() hOnKeyUp(bool Function(int keyCode) handler) {
  final stream = html.window.onKeyUp.listen((final event) {
    handler(event.keyCode);
  });
  return () => stream.cancel();
}

/// ...
void Function() hOnKeyDown(bool Function(int keyCode) handler) {
  final stream = html.window.onKeyDown.listen((final event) {
    handler(event.keyCode);
  });
  return () => stream.cancel();
}

/// ...
void Function() hOnKeyRepeat(bool Function(int keyCode) handler) {
  final stream = html.window.onKeyPress.listen((final event) {
    handler(event.keyCode);
  });
  return () => stream.cancel();
}
