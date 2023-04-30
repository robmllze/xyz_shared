// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "bodyTextStyle": "TextStyle",
    "actionTextStyle": "TextStyle",
    "backgroundColor": "Color",
    "icon": "Icon?",
    "borderRadius": "BorderRadius",
    "shadow": "BoxShadow",
    "loaderMakeup": "MakeupLoader",
  },
)
class ServiceSnackBar {
  //
  //
  //

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  //
  //
  //

  ServiceSnackBar(this.scaffoldMessengerKey);

  //
  //
  //

  FutureOr<void> hide([Duration? delay]) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    this.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  //
  //
  //

  Future<void> show({
    required String text,
    Widget? before,
    Widget? after,
    MakeupServiceSnackBar? makeup,
    Future<void> Function()? process,
  }) async {
    final hasProcess = process != null;
    final snackbar = this._build(
      before: before,
      text: text,
      after: after,
      duration: hasProcess ? null : const Duration(seconds: 3),
      makeup: makeup ?? G.theme.snackBarDefault(),
    );
    this.scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
    if (hasProcess) {
      await process();
      this.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    }
  }

  //
  //
  //

  SnackBar _build({
    Widget? before,
    required String text,
    required MakeupServiceSnackBar makeup,
    Widget? after,
    VoidCallback? onTap,
    Duration? duration,
  }) {
    final before1 = before ?? makeup.icon;
    return SnackBar(
      content: Consumer(
        builder: (_, final ref, __) {
          final bottomNavigationBar = G.managerBottomNavigationBar.pValue.watch(ref);
          return Padding(
            padding: EdgeInsets.only(
              bottom: bottomNavigationBar == null ? $80 : 0.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: makeup.backgroundColor,
                borderRadius: makeup.borderRadius,
                boxShadow: [makeup.shadow],
              ),
              child: Padding(
                padding: EdgeInsets.all($12),
                child: GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      if (before1 != null) ...[
                        before1,
                        SizedBox(width: $12),
                      ],
                      Expanded(
                        child: MyMarkdownText(
                          text,
                          style: makeup.bodyTextStyle,
                        ),
                      ),
                      if (after != null) ...[
                        SizedBox(width: $12),
                        after,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0.0,
      duration: duration ?? const Duration(seconds: 365),
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.zero,
    );
  }
}
