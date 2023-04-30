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
