// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// ...
class MyDialogBody extends StatefulWidget {
  //
  //
  //

  final MakeupDialog makeup;
  final Widget child;
  final MyFacade facade;
  final Widget? header;
  final Future<void> Function()? onClose;

  //
  //
  //

  const MyDialogBody({
    Key? key,
    required this.makeup,
    required this.child,
    this.facade = const MyFacade(),
    this.header,
    this.onClose,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyDialogBody> {
  @override
  Widget build(_) {
    final makeup = this.widget.makeup;
    final header = this.widget.header;
    final onClose = this.widget.onClose;
    return Material(
      color: Colors.transparent,
      child: MyAnimatedFade(
        layer2: this
            .widget
            .facade
            .copyWith(
              child: Container(
                color: makeup.overlayColor,
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: $24),
                      child: Container(
                        width: double.infinity,
                        decoration: makeup.decoration,
                        child: ClipRRect(
                          borderRadius: makeup.decoration.borderRadius,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  if (header != null) header,
                                  this.widget.child,
                                ],
                              ),
                              if (onClose != null)
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: makeup.closeIconBackroundColor,
                                      borderRadius: makeup.decoration.borderRadius,
                                    ),
                                    child: MyButtonIcon(
                                      icon: Icon(
                                        Icons.close,
                                        color: makeup.closeIconForegroundColor,
                                        size: $16,
                                      ),
                                      onTap: onClose,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
            .draw(),
      ),
    );
  }
}
