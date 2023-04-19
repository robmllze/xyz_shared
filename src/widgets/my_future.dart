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

class MyFuture<T> extends StatelessWidget {
  //
  //
  //

  final Future<T?> future;
  final Widget? Function(BuildContext context, AsyncSnapshot<T?> result)? onActive,
      onWaiting,
      onNone,
      onDone;
  final MakeupLoader? makeup;

  //
  //
  //

  const MyFuture({
    Key? key,
    required this.future,
    this.onActive,
    this.onWaiting,
    this.onNone,
    this.onDone,
    this.makeup,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    return FutureBuilder<T?>(
      future: this.future,
      builder: (final context, final snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return this.onNone?.call(context, snapshot) ?? const SizedBox();
          case ConnectionState.waiting:
            return this.onWaiting?.call(context, snapshot) ??
                MyLoader(makeup: this.makeup ?? G.theme.loaderPrimary());
          case ConnectionState.active:
            return this.onActive?.call(context, snapshot) ?? const SizedBox();
          case ConnectionState.done:
            return this.onDone?.call(context, snapshot) ?? const SizedBox();
        }
      },
    );
  }
}
