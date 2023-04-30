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
class MyDialogOkay extends MyDialog {
  //
  //
  //

  final MakeupDialog? dialogMakeup;
  final MakeupButton? buttonMakeup;
  final String title, message, labelOkay;
  final Widget? header;
  final Future<void> Function()? onTapOkay, onClose;

  //
  //
  //

  MyDialogOkay({
    Key? key,
    this.dialogMakeup,
    this.buttonMakeup,
    required this.title,
    required this.message,
    required this.labelOkay,
    this.header,
    this.onTapOkay,
    this.onClose,
    Future<void> Function(Object? e)? onError,
    bool shouldCloseOnComplete = true,
  }) : super(
          key: key,
          onError: onError,
          shouldCloseOnComplete: shouldCloseOnComplete,
        );

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyDialogOkay> {
  @override
  Widget build(_) {
    final dialogMakeup = this.widget.dialogMakeup ?? G.theme.dialogDefault();
    final onClose = this.widget.onClose;
    return MyDialogBody(
      makeup: dialogMakeup,
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
            wHeight20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtonClear(
                  child: Text(
                    this.widget.labelOkay,
                    style: G.theme.textStyles.p2Primary.copyWith(
                      letterSpacing: 1.0.scaled,
                      fontWeight: FONT_WEIGHT_SEMI_BOLD,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await this.widget.onTapOkay?.call();
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
