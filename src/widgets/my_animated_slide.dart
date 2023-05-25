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
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final MyAnimatedSlide_Direction direction;
  final double extent;

  //
  //
  //

  const MyAnimatedSlide({
    Key? key,
    this.child,
    this.color = Colors.transparent,
    this.delay = const Duration(milliseconds: 0),
    this.direction = MyAnimatedSlide_Direction.BOTTOM_TO_TOP,
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
  );

  //
  //
  //

  late final _extent = this.widget.extent.abs();

  late final _animation = Tween<Offset>(
    begin: Offset(
      this.widget.direction == MyAnimatedSlide_Direction.RIGHT_TO_LEFT
          ? this._extent
          : this.widget.direction == MyAnimatedSlide_Direction.LEFT_TO_RIGHT
              ? -this._extent
              : 0.0,
      this.widget.direction == MyAnimatedSlide_Direction.BOTTOM_TO_TOP
          ? this._extent
          : this.widget.direction == MyAnimatedSlide_Direction.TOP_TO_BOTTOM
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

  @override
  void initState() {
    Future.delayed(this.widget.delay, () => this._controller.forward());
    super.initState();
  }

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

enum MyAnimatedSlide_Direction {
  LEFT_TO_RIGHT,
  RIGHT_TO_LEFT,
  BOTTOM_TO_TOP,
  TOP_TO_BOTTOM,
}
