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

class MyFutureLoader extends StatelessWidget {
  //
  //
  //

  final MakeupLoader? makeup;
  final Future<void> future;
  final bool shouldIndicateWhenDone;

  //
  //
  //

  const MyFutureLoader({
    Key? key,
    this.makeup,
    required this.future,
    this.shouldIndicateWhenDone = true,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.makeup ?? G.theme.loaderDefault();
    return SizedBox.square(
      dimension: makeup.size,
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
                    backgroundColor: makeup.backgroundColor,
                    valueColor: makeup.valueColor,
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
