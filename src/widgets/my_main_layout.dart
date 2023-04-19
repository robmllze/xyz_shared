// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '../../../all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyMainLayout extends StatelessWidget {
  //
  //
  //

  final Widget? header;
  final Widget? footer;
  final Widget? top, body, bottom;

  //
  //
  //

  const MyMainLayout({
    Key? key,
    this.header,
    this.footer,
    this.top,
    this.body,
    this.bottom,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return MyColumn(
      children: [
        const SizedBox(width: double.infinity),
        if (this.top != null) this.top!,
        if (this.header != null) this.header!,
        if (this.body != null)
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              child: body,
            ),
          ),
        SizedBox(child: this.footer),
        SizedBox(child: this.bottom),
      ],
    );
  }
}
