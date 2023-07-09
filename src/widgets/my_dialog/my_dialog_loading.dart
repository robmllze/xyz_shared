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
class MyDialogLoading extends MyDialog {
  //
  //
  //

  final MakeupDialog? dialogMakeup;
  final MakeupLoader? loaderMakeup;
  final MyFacade facade;
  final String title, message;
  final Future<void> Function()? loadingBody;
  final Widget? header;

  //
  //
  //

  MyDialogLoading({
    Key? key,
    this.dialogMakeup,
    this.loaderMakeup,
    this.facade = const MyFacade(),
    required this.title,
    required this.message,
    this.loadingBody,
    this.header,
    Future<void> Function(Object? e)? onError,
    bool shouldCloseOnComplete = false,
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

class _State extends State<MyDialogLoading> {
  @override
  Widget build(_) {
    final dialogMakeup = this.widget.dialogMakeup ?? G.theme.dialogDefault();
    return MyDialogBody(
      makeup: dialogMakeup,
      facade: this.widget.facade,
      header: this.widget.header,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $32, vertical: $48),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyFutureLoader(
              makeup: (this.widget.loaderMakeup ?? G.theme.loaderDefault())..size = $32,
              future: () async {
                try {
                  await this.widget.loadingBody?.call();
                } catch (e) {
                  await this.widget.onError?.call(e);
                }
                this.widget.completer.complete();
              }(),
            ),
            wWidth16(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.widget.title,
                    style: dialogMakeup.titleTextStyle,
                  ),
                  wHeight4(),
                  Text(
                    this.widget.message,
                    style: dialogMakeup.messageTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
