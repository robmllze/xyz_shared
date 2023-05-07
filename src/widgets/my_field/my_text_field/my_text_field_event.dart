// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyTextFieldEvent {
  //
  //
  //

  final MakeupTextField makeup;
  final MyTextFieldState state;
  final String text;
  final bool hasFocus;
  final bool hasError;
  final bool enabled;
  final bool readOnly;
  final bool obscured;
  final String? hint;
  final String? error;
  final List<String> autoFillHints;

  //
  //
  //

  MyTextFieldEvent(
    this.makeup,
    this.state,
    this.text,
    this.hasFocus,
    this.hasError,
    this.enabled,
    this.readOnly,
    this.obscured,
    this.hint,
    this.error,
    this.autoFillHints,
  );

  //
  //
  //

  MyTextFieldEvent copyWith({
    MakeupTextField? makeup,
    MyTextField? widget,
    MyTextFieldState? state,
    String? text,
    bool? hasFocus,
    bool? hasError,
    bool? enabled,
    bool? readOnly,
    bool? obscured,
    String? hint,
    String? error,
    List<String>? autoFillHints,
  }) {
    return MyTextFieldEvent(
      makeup ?? this.makeup,
      state ?? this.state,
      text ?? this.text,
      hasFocus ?? this.hasFocus,
      hasError ?? this.hasError,
      enabled ?? this.enabled,
      readOnly ?? this.readOnly,
      obscured ?? this.obscured,
      hint ?? this.hint,
      error ?? this.error,
      autoFillHints ?? this.autoFillHints,
    );
  }
}
