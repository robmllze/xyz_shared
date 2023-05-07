// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyAction extends StatelessWidget {
  //
  //
  //

  final Widget? first, second;
  final void Function()? onPressed, onPressedFirst, onPressedSecond;
  final Widget? firstIcon, secondIcon;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? firstIconPadding;
  final EdgeInsets? firstPadding;
  final EdgeInsets? secondPadding;
  final EdgeInsets? secondIconPadding;

  //
  //
  //

  const MyAction({
    Key? key,
    this.first,
    this.second,
    this.firstIcon,
    this.secondIcon,
    this.onPressed,
    this.onPressedFirst,
    this.onPressedSecond,
    this.width,
    this.height,
    this.padding,
    this.firstIconPadding,
    this.firstPadding,
    this.secondPadding,
    this.secondIconPadding,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final firstIconPadding = this.firstIconPadding ?? EdgeInsets.only(left: 8.0.scaled);
    final firstPadding = this.firstPadding ?? EdgeInsets.only(left: 16.0.scaled);
    final secondIconPadding = this.secondIconPadding ?? EdgeInsets.only(right: 8.0.scaled);
    final secondPadding = this.secondPadding ?? EdgeInsets.only(right: 16.0.scaled);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: this.onPressed,
      child: Padding(
        padding: this.padding ?? EdgeInsets.zero,
        child: SizedBox(
          width: this.width,
          height: this.height,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                if (this.firstIcon != null)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: this.onPressedFirst,
                    child: Padding(
                      padding: firstIconPadding,
                      child: this.firstIcon,
                    ),
                  ),
                if (this.first != null)
                  Expanded(
                    child: Padding(
                      padding: firstIcon == null ? firstIconPadding : firstPadding,
                      child: this.first!,
                    ),
                  ),
                if (this.second != null)
                  Expanded(
                    child: Padding(
                      padding: secondIcon == null ? secondIconPadding : secondPadding,
                      child: this.second!,
                    ),
                  ),
                if (this.secondIcon != null)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: this.onPressedSecond,
                    child: Padding(
                      padding: secondIconPadding,
                      child: this.secondIcon,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
