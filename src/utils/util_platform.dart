// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/widgets.dart' show MediaQueryData, WidgetsBinding;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class CurrentPlatform {
  static final isOsIos = defaultTargetPlatform == TargetPlatform.iOS;
  static final isOsAndroid = defaultTargetPlatform == TargetPlatform.android;
  static final isOsMobile = isOsIos || isOsAndroid;
  static final isOsWindows = defaultTargetPlatform == TargetPlatform.windows;
  static final isOsMacOs = defaultTargetPlatform == TargetPlatform.macOS;
  static final isOsLinux = defaultTargetPlatform == TargetPlatform.linux;
  static final isOsApple = isOsIos || isOsMacOs;
  static final isOsDeskop = isOsWindows || isOsMacOs || isOsLinux;
  static bool get isTablet => isOsMobile && isWindowSizeTabletOrDesktop;
  static bool get isMobile => isOsMobile && isWindowSizeMobile;
  static bool get isDesktop => isOsWindows || isOsMacOs || isOsLinux;
  static bool get isWindowSizeMobile {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550.0;
  }

  static bool get isWindowSizeTabletOrDesktop => !isWindowSizeMobile;
}
