// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  names: {},
  parameters: {
    "backgroundColor": "Color?",
    "color": "Color?",
    "valueColor": "Animation<Color?>?",
    "size": "double?",
    "strokeWidth": "double?",
  },
)
class MyLoader extends StatelessWidget {
  //
  //
  //

  final MakeupLoader? makeup;

  //
  //
  //

  const MyLoader({
    Key? key,
    this.makeup,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.makeup ?? G.theme.loaderDefault();
    return Center(
      child: SizedBox.square(
        dimension: makeup.size,
        child: CircularProgressIndicator(
          color: makeup.color,
          backgroundColor: makeup.backgroundColor,
          valueColor: makeup.valueColor,
          strokeWidth: makeup.strokeWidth ?? $4,
        ),
      ),
    );
  }
}
