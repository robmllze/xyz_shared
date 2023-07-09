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
class MyDialogAOrB extends MyDialog {
  //
  //
  //

  final MakeupDialog? dialogMakeup;
  final MyFacade facade;
  final MakeupButton? buttonMakeupA, buttonMakeupB;
  final String title, message, labelB, labelA;
  final Future<void> Function()? onTapB, onTapA, onClose;
  final Widget? header;

  //
  //
  //

  MyDialogAOrB({
    Key? key,
    this.dialogMakeup,
    this.facade = const MyFacade(),
    this.buttonMakeupA,
    this.buttonMakeupB,
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

class _State extends State<MyDialogAOrB> {
  @override
  Widget build(_) {
    final dialogMakeup = this.widget.dialogMakeup ?? G.theme.dialogDefault();
    final buttonMakeupA = this.widget.buttonMakeupA ?? G.theme.buttonDefault();
    final buttonMakeupB = this.widget.buttonMakeupB ?? G.theme.buttonDefault();
    final onClose = this.widget.onClose;
    return MyDialogBody(
      makeup: dialogMakeup,
      facade: this.widget.facade,
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
        padding: EdgeInsets.symmetric(horizontal: $28),
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
            wHeight24(),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: MyButton.loading(
                    label: this.widget.labelA,
                    expanded: true,
                    makeup: buttonMakeupA,
                    onTap: () async {
                      try {
                        await this.widget.onTapA?.call();
                      } catch (e) {
                        await this.widget.onError?.call(e);
                      }
                      this.widget.completer.complete();
                    },
                  ),
                ),
                wWidth12(),
                Expanded(
                  flex: 4,
                  child: MyButton.loading(
                    label: this.widget.labelB,
                    expanded: true,
                    makeup: buttonMakeupB,
                    onTap: () async {
                      try {
                        await this.widget.onTapB?.call();
                      } catch (e) {
                        await this.widget.onError?.call(e);
                      }
                      this.widget.completer.complete();
                    },
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
            wHeight16(),
          ],
        ),
      ),
    );
  }
}
