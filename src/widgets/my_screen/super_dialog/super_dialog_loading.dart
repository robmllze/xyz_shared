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
class SuperDialogLoading extends SuperDialog {
  //
  //
  //

  final MakeupScreen makeup;
  final String title, message;
  final Future<void> Function()? onLoading;
  final Widget? header;

  //
  //
  //

  SuperDialogLoading({
    Key? key,
    required this.makeup,
    required this.title,
    required this.message,
    this.onLoading,
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

class _State extends State<SuperDialogLoading> {
  @override
  Widget build(_) {
    return SuperDialogBody(
      makeup: this.widget.makeup,
      header: this.widget.header,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.0.scaled, vertical: 50.0.scaled),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyLoaderDynamic(
              makeup: G.theme.loaderPrimary(),
              size: 30.0.scaled,
              future: () async {
                try {
                  await this.widget.onLoading?.call();
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
                    style: G.theme.textStyles.h5,
                  ),
                  wHeight4(),
                  Text(
                    this.widget.message,
                    style: G.theme.textStyles.p1,
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
