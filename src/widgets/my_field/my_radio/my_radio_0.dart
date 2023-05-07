// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRadio0 extends StatefulWidget {
  //
  //
  //

  final MakeupRadio makeup;
  final bool initial;
  final Widget? child;
  final void Function(bool)? onTap;

  //
  //
  //

  const MyRadio0({
    Key? key,
    required this.makeup,
    this.initial = false,
    this.child,
    this.onTap,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyRadio0> {
  //
  //
  //

  late bool _value = this.widget.initial;

  //
  //
  //

  @override
  Widget build(_) {
    return GestureDetector(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox.square(
            dimension: 20.0.scaled,
            child: MyRadio1(
              value: this._value,
              makeup: this.widget.makeup,
            ),
          ),
          SizedBox(width: 12.0.scaled),
          SizedBox(child: this.widget.child)
        ],
      ),
      onTap: () {
        this.setState(() => this._value = !this._value);
        this.widget.onTap?.call(this._value);
      },
    );
  }
}
