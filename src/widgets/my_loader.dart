// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Xyz Shared
//
// This code is copyrighted - See LICENCE.txt
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

  final MakeupLoader makeup;

  //
  //
  //

  const MyLoader({
    Key? key,
    required this.makeup,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return Center(
      child: SizedBox.square(
        dimension: this.makeup.size,
        child: CircularProgressIndicator(
          color: this.makeup.color,
          backgroundColor: this.makeup.backgroundColor,
          valueColor: this.makeup.valueColor,
          strokeWidth: this.makeup.strokeWidth ?? $4,
        ),
      ),
    );
  }
}
