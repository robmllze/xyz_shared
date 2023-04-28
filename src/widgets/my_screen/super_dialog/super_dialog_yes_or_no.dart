// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// ...
class SuperDialogAOrB extends SuperDialog {
  //
  //
  //

  final MakeupScreen makeup;
  final String title, message, labelB, labelA;
  final Future<void> Function()? onTapB, onTapA, onClose;
  final Widget? header;

  //
  //
  //

  SuperDialogAOrB({
    Key? key,
    required this.makeup,
    required this.title,
    required this.message,
    required this.labelA,
    required this.labelB,
    this.onClose,
    this.onTapA,
    this.onTapB,
    this.header,
    Future<void> Function(Object? e)? onError,
    bool shouldAutoCloseOnComplete = true,
  }) : super(
          key: key,
          onError: onError,
          shouldCloseOnComplete: shouldAutoCloseOnComplete,
        );

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<SuperDialogAOrB> {
  @override
  Widget build(_) {
    final onClose = this.widget.onClose;
    return SuperDialogBody(
      makeup: this.widget.makeup,
      header: this.widget.header,
      onClose: onClose != null
          ? () async {
              try {
                await onClose.call();
              } catch (e) {
                await this.widget.onError?.call(e);
              }
              this.widget.completer.complete();
            }
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.0.scaled),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wHeight40(),
            Text(
              this.widget.title,
              style: G.theme.textStyles.h5,
            ),
            wHeight16(),
            Text(
              this.widget.message,
              style: G.theme.textStyles.p1,
            ),
            wHeight24(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  label: this.widget.labelA,
                  makeup: G.theme.buttonPrimary(),
                  onTap: () async {
                    try {
                      await this.widget.onTapA?.call();
                    } catch (e) {
                      await this.widget.onError?.call(e);
                    }
                    this.widget.completer.complete();
                  },
                ),
                wWidth12(),
                MyButton(
                  label: this.widget.labelB,
                  makeup: G.theme.buttonPrimary(),
                  onTap: () async {
                    try {
                      await this.widget.onTapB?.call();
                    } catch (e) {
                      await this.widget.onError?.call(e);
                    }
                    this.widget.completer.complete();
                  },
                ),
              ],
            ),
            wHeight16(),
          ],
        ),
      ),
    );
  }
}
