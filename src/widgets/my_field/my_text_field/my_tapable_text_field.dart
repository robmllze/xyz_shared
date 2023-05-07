// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyTappableTextField extends StatelessWidget {
  //
  //
  //

  final MakeupTextField? makeup;
  final Pod<String>? pTitle;
  final IconData? icon;
  final Pod<String> pValue;
  final Pod<bool>? pEnabled;
  final FutureOr<String?> Function()? onTap;

  //
  //
  //

  const MyTappableTextField({
    Key? key,
    this.pTitle,
    this.makeup,
    this.icon,
    required this.pValue,
    this.onTap,
    this.pEnabled,
  }) : super(key: key);

  //
  //
  //

  static FutureOr<String?> onTapDate(Pod<dynamic> pFieldValue) async {
    final completer = Completer<String?>();
    await G.router.push(
      ScreenDialogPickDateConfiguration(
        onPickDate: (final selected) async {
          pFieldValue.set(selected);
          final formatted = (selected ?? DateTime.now()).dMMMMy(G.serviceLocale.code);
          completer.complete(formatted);
        },
      ),
    );
    return completer.future;
  }

  //
  //

  @override
  Widget build(_) {
    final makeup = this.makeup ?? G.theme.textFieldDefault();
    this.icon != null;
    return MyTextField(
      makeup: this.icon == null
          ? makeup
          : makeup.copyWith(
              leftWidgetBuilder: (_) => Padding(
                padding: EdgeInsets.all($8),
                child: MyIcon(
                  this.icon!,
                  makeup: G.theme.iconNeutralS(),
                ),
              ),
            ),
      pTitle: this.pTitle,
      pValue: this.pValue,
      pReadOnly: Pod.temp(true),
      onTapInside: (final event) async {
        if (event.enabled) {
          final state = event.state;
          state.focusNode.unfocus();
          final result = await this.onTap?.call();
          if (result != null) {
            await state.pValue.set(result);
          }
        }
      },
    );
  }
}
