// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
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
    final buttonMakeup = this.widget.buttonMakeup ?? G.theme.buttonDefault();
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
              style: dialogMakeup.titleTextStyle,
            ),
            wHeight16(),
            Text(
              this.widget.message,
              style: dialogMakeup.messageTextStyle,
            ),
            wHeight20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton.loading(
                  label: this.widget.labelOkay,
                  makeup: buttonMakeup,
                  onTap: () async {
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
