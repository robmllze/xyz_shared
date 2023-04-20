// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Xyz Shared
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/services.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class TextInputFormatter_USPhone extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(final oldValue, final newValue) {
    var text = newValue.text;
    text = text.replaceAll(RegExp(r'[^\d]+'), ""); // remove any non-digit characters
    final l = text.length;
    if (l > 1 && l <= 3) {
      text = '($text';
    } else if (l == 4) {
      text = '(${text.substring(0, 3)})${text.substring(3)}';
    } else if (l > 4 && l < 6) {
      text = '(${text.substring(0, 3)})-${text.substring(3)}';
    } else if (l == 6) {
      text = '(${text.substring(0, 3)})-${text.substring(3)}';
    } else if (l > 6 && l < 10) {
      text = '(${text.substring(0, 3)})-${text.substring(3, 6)}-${text.substring(6)}';
    } else {
      text = '(${text.substring(0, 3)})-${text.substring(3, 6)}-${text.substring(6, 10)}';
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
