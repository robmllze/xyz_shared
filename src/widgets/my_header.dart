// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "makeupScreen": "MakeupScreen",
    "minHeight": "double",
    "decoration": "BoxDecoration",
    "padding": "double",
  },
)
class MyHeader extends StatelessWidget {
  //
  //
  //

  final MakeupHeader makeup;
  final Widget? title;
  final void Function()? onTapDownTitle;
  final Widget? left;
  final void Function()? onTapDownLeft;
  final Widget? center;
  final void Function()? onTapDownCenter;
  final Widget? centerLeft;
  final void Function()? onTapDownCenterLeft;
  final Widget? centerRight;
  final void Function()? onTapDownCenterRight;
  final Widget? right;
  final void Function()? onTapDownRight;
  final Widget? top;
  final Widget? bottom;

  //
  //
  //

  const MyHeader({
    super.key,
    required this.makeup,
    this.title,
    this.onTapDownTitle,
    this.left,
    this.onTapDownLeft,
    this.center,
    this.onTapDownCenter,
    this.centerLeft,
    this.onTapDownCenterLeft,
    this.centerRight,
    this.onTapDownCenterRight,
    this.right,
    this.onTapDownRight,
    this.top,
    this.bottom,
  });

  //
  //
  //

  @override
  Widget build(_) {
    final p1 = this.makeup.padding;
    final p2 = 2.0 * p1;
    final Width1 = SizedBox(width: p1);
    Widget wPadded(Widget child) => Padding(padding: EdgeInsets.all(p1), child: child);
    Widget wSection(
      Widget child,
      void Function()? onTap,
    ) {
      final constrainedChild = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: p2,
          minHeight: p2,
        ),
        child: Center(
          child: child,
        ),
      );
      return onTap != null
          ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) => onTap!(),
              child: constrainedChild,
            )
          : constrainedChild;
    }

    return MyHeaderBar(
      key: this.key,
      makeup: this.makeup,
      title: this.title != null ? wSection(this.title!, this.onTapDownTitle) : null,
      child: MyColumn(
        children: [
          if (this.top != null) ...[wPadded(this.top!)],
          Row(
            children: [
              this.left != null ? wSection(this.left!, this.onTapDownLeft) : Width1,
              if (this.centerLeft != null) wSection(this.centerLeft!, this.onTapDownCenterLeft),
              Expanded(
                child: this.center != null
                    ? wSection(this.center!, this.onTapDownCenter)
                    : const SizedBox(),
              ),
              if (this.centerRight != null) wSection(this.centerRight!, this.onTapDownCenterRight),
              this.right != null ? wSection(this.right!, this.onTapDownRight) : Width1,
            ],
          ),
          if (this.bottom != null) ...[wPadded(this.bottom!)],
        ],
      ),
    );
  }
}
