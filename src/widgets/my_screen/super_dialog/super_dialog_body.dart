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

/// ...
class SuperDialogBody extends StatefulWidget {
  //
  //
  //

  final MakeupScreen makeup;
  final Widget child;
  final Widget? header;
  final Future<void> Function()? onClose;

  //
  //
  //

  const SuperDialogBody({
    Key? key,
    required this.makeup,
    required this.child,
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

class _State extends State<SuperDialogBody> {
  @override
  Widget build(_) {
    final makeup = this.widget.makeup;
    final header = this.widget.header;
    final onClose = this.widget.onClose;
    return Material(
      color: Colors.transparent,
      child: MyAnimatedFade(
        layer1: Container(color: G.theme.palette.shade100.withOpacity(0.40)),
        layer2: Column(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.scaled),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: makeup.backgroundColor,
                  borderRadius: BorderRadius.circular(4.0.scaled),
                  boxShadow: [
                    BoxShadow(
                      color: G.theme.palette.shade100.withOpacity(0.1),
                      blurRadius: 4.0.scaled,
                      spreadRadius: 2.0.scaled,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0.scaled),
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
                              color: G.theme.palette.contrast900.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.0.scaled),
                            ),
                            child: MyButtonIcon(
                              icon: Icon(
                                Icons.close,
                                color: G.theme.palette.contrast0,
                                size: 16.0.scaled,
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
    );
  }
}
