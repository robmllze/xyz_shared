// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:crypto/crypto.dart' show sha256;
import 'dart:convert' show utf8;

import 'package:flutter/painting.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ColorUtils on Color {
  Color get inverted {
    return Color.fromRGBO(
      255 - this.red,
      255 - this.green,
      255 - this.blue,
      this.opacity,
    );
  }

  Color withShadeCode(int shadeCode) {
    final hsl = HSLColor.fromColor(this);
    final lighter = hsl.withLightness((hsl.lightness + shadeCode / 900) % 1);
    return lighter.toColor();
  }

  Color withSaturation(double saturation) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withSaturation(saturation).toColor();
  }

  Color lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final darkened = hsl.withLightness(hsl.lightness * amount);
    return darkened.toColor();
  }

  Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final darkened = hsl.withLightness(hsl.lightness * (1 - amount));
    return darkened.toColor();
  }
}

Color generateAvatarColorFromName(String name) {
  // Generate a hash value from the name.
  final bytes = utf8.encode(name);
  final hash = sha256.convert(bytes);
  final hashString = hash.toString();

  // Convert the first 8 characters of the hash to an integer.
  final hashInteger = int.parse(hashString.substring(0, 8), radix: 16);

  // Map the hash integer to a hue value between 0 and 359.
  final hue = hashInteger % 360;

  // Create a color with the desired saturation, lightness, and alpha values.
  return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.35, 0.7).toColor();
}
