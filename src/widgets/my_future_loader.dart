// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyLoaderDynamic extends StatelessWidget {
  //
  //
  //

  final Future<void> future;
  final MakeupLoader makeup;
  final double? size;
  final bool shouldIndicateWhenDone;

  //
  //
  //

  const MyLoaderDynamic({
    Key? key,
    required this.future,
    required this.makeup,
    this.shouldIndicateWhenDone = true,
    this.size,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return SizedBox.square(
      dimension: this.size ?? $32,
      child: Center(
        child: LayoutBuilder(
          builder: (_, final constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            final smallest = w < h ? w : h;
            return MyFuture<void>(
              future: this.future,
              onDone: (_, final snapshot) {
                if (snapshot.hasError) {
                  return Icon(
                    Icons.error_outline,
                    color: makeup.color,
                    size: smallest,
                  );
                }
                if (shouldIndicateWhenDone) {
                  return Icon(
                    Icons.check_circle_outline,
                    color: makeup.color,
                    size: smallest,
                  );
                }
                return null;
              },
              onWaiting: (_, __) => SizedBox.square(
                dimension: smallest,
                child: Padding(
                  padding: EdgeInsets.all(0.12 * smallest),
                  child: CircularProgressIndicator(
                    color: Colors.transparent,
                    backgroundColor: this.makeup.backgroundColor,
                    valueColor: this.makeup.valueColor,
                    strokeWidth: 0.11 * smallest,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
