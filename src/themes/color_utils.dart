import 'package:flutter/painting.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ColorInverted on Color {
  Color get inverted {
    return Color.fromRGBO(
      255 - this.red,
      255 - this.green,
      255 - this.blue,
      this.opacity,
    );
  }
}
