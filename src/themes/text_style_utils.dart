import 'package:flutter/material.dart';

import 'color_utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const FONT_WEIGHT_BLACK = FontWeight.w900;
const FONT_WEIGHT_EXTRA_BOLD = FontWeight.w800;
const FONT_WEIGHT_BOLD = FontWeight.w700;
const FONT_WEIGHT_SEMI_BOLD = FontWeight.w600;
const FONT_WEIGHT_MEDIUM = FontWeight.w500;
const FONT_WEIGHT_REGULAR = FontWeight.w400;
const FONT_WEIGHT_LIGHT = FontWeight.w300;
const FONT_WEIGHT_EXTRA_LIGHT = FontWeight.w200;
const FONT_WEIGHT_THIN = FontWeight.w100;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension TextStyleWithInvertedColor on TextStyle {
  TextStyle get wInvertedColor {
    return this.copyWith(
      color: this.color == null ? Colors.white : this.color!.inverted,
    );
  }
}

extension TextStyleWithFontWeights on TextStyle {
  TextStyle get wBlack => this.copyWith(fontWeight: FONT_WEIGHT_BLACK);
  TextStyle get wExtraBold => this.copyWith(fontWeight: FONT_WEIGHT_EXTRA_BOLD);
  TextStyle get wBold => this.copyWith(fontWeight: FONT_WEIGHT_BOLD);
  TextStyle get wSemiBold => this.copyWith(fontWeight: FONT_WEIGHT_SEMI_BOLD);
  TextStyle get wMedium => this.copyWith(fontWeight: FONT_WEIGHT_MEDIUM);
  TextStyle get wRegular => this.copyWith(
        fontWeight: FONT_WEIGHT_REGULAR,
      );
  TextStyle get wLight => this.copyWith(fontWeight: FONT_WEIGHT_LIGHT);
  TextStyle get wExtraLight => this.copyWith(fontWeight: FONT_WEIGHT_EXTRA_LIGHT);
  TextStyle get wThin => this.copyWith(fontWeight: FONT_WEIGHT_THIN);
}

extension TextStyleWithDecorations on TextStyle {
  TextStyle get wUnderlined => this.copyWith(decoration: TextDecoration.underline);
  TextStyle get wOverlined => this.copyWith(decoration: TextDecoration.overline);
  TextStyle get wLineThough => this.copyWith(decoration: TextDecoration.lineThrough);
}

extension TextStyleWithItalic on TextStyle {
  TextStyle get wItalic => this.copyWith(fontStyle: FontStyle.italic);
}

extension TextStyleWithSpacing on TextStyle {
  TextStyle wWordSpacing(double wordSpacing) => this.copyWith(wordSpacing: wordSpacing);
  TextStyle wLetterSpacing(double letterSpacing) => this.copyWith(letterSpacing: letterSpacing);
}
