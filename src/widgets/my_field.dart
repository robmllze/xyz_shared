import '/all.dart';

abstract class MyField {
  final Pod<String>? pHint;
  final Pod pValue;
  final Pod? pTitle;
  final Pod<bool>? pEnabled;
  final Pod<bool>? pReadOnly;
  final Pod<bool>? pObscured;

  const MyField({
    required this.pValue,
    this.pHint,
    this.pTitle,
    this.pEnabled,
    this.pReadOnly,
    this.pObscured,
  });
}
