// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyAnimatedSlide extends StatefulWidget {
  //
  //
  //

  final Widget? child;
  final Color color;
  final Duration duration;
  final Curve curve;
  final MyAnimatedSlideDirection direction;
  final double extent;

  //
  //
  //

  const MyAnimatedSlide({
    Key? key,
    this.child,
    this.color = Colors.transparent,
    this.direction = MyAnimatedSlideDirection.BOTTOM_TO_TOP,
    this.curve = Curves.easeInOutCirc,
    this.duration = const Duration(milliseconds: 250),
    this.extent = 0.25,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyAnimatedSlide> with SingleTickerProviderStateMixin {
  //
  //
  //

  late final _controller = AnimationController(
    vsync: this,
    duration: this.widget.duration,
  )..forward();

  //
  //
  //

  late final _extent = this.widget.extent.abs();

  late final _animation = Tween<Offset>(
    begin: Offset(
      this.widget.direction == MyAnimatedSlideDirection.RIGHT_TO_LEFT
          ? this._extent
          : this.widget.direction == MyAnimatedSlideDirection.LEFT_TO_RIGHT
              ? -this._extent
              : 0.0,
      this.widget.direction == MyAnimatedSlideDirection.BOTTOM_TO_TOP
          ? this._extent
          : this.widget.direction == MyAnimatedSlideDirection.TOP_TO_BOTTOM
              ? -this._extent
              : 0.0,
    ),
    end: const Offset(0.0, 0.0),
  ).animate(
    CurvedAnimation(
      parent: this._controller,
      curve: this.widget.curve,
    ),
  );

  //
  //
  //

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  //
  //
  //

  @override
  Widget build(_) {
    return Container(
      color: this.widget.color,
      child: SlideTransition(
        position: _animation,
        child: this.widget.child,
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum MyAnimatedSlideDirection {
  LEFT_TO_RIGHT,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  TOP_TO_BOTTOM,
}
