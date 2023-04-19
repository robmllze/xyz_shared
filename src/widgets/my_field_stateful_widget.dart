import 'package:flutter/cupertino.dart';

import '/all.dart';

abstract class MyFieldWidget extends StatefulWidget {
  final Pod pValue;
  final Pod? pTitle;
  final Pod<bool>? pEnabled;
  final Pod<bool>? pObscured;
  final Pod<bool>? pReadOnly;
  final Pod<String?>? pError;

  const MyFieldWidget({
    super.key,
    required this.pValue,
    this.pTitle,
    this.pEnabled,
    this.pObscured,
    this.pReadOnly,
    this.pError,
  });

  @override
  MyFieldState createState();
}

abstract class MyFieldState<T extends MyFieldWidget> extends State<T> {
  late final pValue = this.widget.pValue;
  late final pError = this.widget.pError;
  late final pTitle = this.widget.pTitle;
  late final pEnabled = this.widget.pEnabled;
  late final pReadOnly = this.widget.pReadOnly;
  late final pObscured = this.widget.pObscured;

  @override
  void dispose() {
    this.pValue.disposeIfRequested();
    this.pTitle?.disposeIfRequested();
    this.pEnabled?.disposeIfRequested();
    this.pReadOnly?.disposeIfRequested();
    this.pObscured?.dispose();
    this.pError?.disposeIfRequested();
    super.dispose();
  }
}
