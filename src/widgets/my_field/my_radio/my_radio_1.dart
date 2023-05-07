// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRadio1 extends StatelessWidget {
  //
  //
  //

  final MakeupRadio makeup;
  final bool value;
  final bool enabled;
  final bool error;

  //
  //
  //

  const MyRadio1({
    Key? key,
    required this.makeup,
    required this.value,
    this.enabled = true,
    this.error = false,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final selectedColor = this.error ? this.makeup.errorColor : this.makeup.selectedColor;
    final unselectedBorderColor =
        this.error ? this.makeup.errorColor : this.makeup.unselectedBorderColor;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 24.0.scaled,
        minHeight: 24.0.scaled,
      ),
      child: LayoutBuilder(
        builder: (_, final constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final smallest = w < h ? w : h;
          return Center(
            child: Container(
              width: smallest,
              height: smallest,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: this.makeup.shape,
                borderRadius:
                    this.makeup.shape == BoxShape.rectangle ? this.makeup.borderRadius : null,
                border: Border.all(
                  width: this.makeup.borderThickness,
                  color: this.enabled
                      ? this.value
                          ? selectedColor
                          : unselectedBorderColor
                      : this.makeup.disabledBorderColor,
                ),
              ),
              child: this.value
                  ? Padding(
                      padding: this.makeup.innerPadding,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: this.makeup.shape == BoxShape.rectangle
                              ? this.makeup.innerBorderRadius
                              : null,
                          color: this.enabled ? selectedColor : this.makeup.disabledSelectedColor,
                          shape: this.makeup.shape,
                        ),
                        child: Center(child: this.makeup.selectedIcon),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
