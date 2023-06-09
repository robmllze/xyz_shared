// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  names: {},
  parameters: {
    "insidePadding": "EdgeInsets",
    "isAlwaysShown": "bool",
    "outsidePadding": "EdgeInsets",
    "style": "VsScrollbarStyle",
  },
)
class MyScrollable extends StatefulWidget {
  //
  //
  //

  final MakeupScrollable? makeup;
  final Widget child;
  final Axis axis;
  final ScrollController controller;
  final bool reverse;
  final void Function()? onEdgeMin, onEdgeMax;

  //
  //
  //

  MyScrollable({
    Key? key,
    this.makeup,
    required this.child,
    this.axis = Axis.vertical,
    this.reverse = false,
    ScrollController? controller,
    this.onEdgeMin,
    this.onEdgeMax,
  })  : this.controller = controller ?? ScrollController(),
        super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyScrollable> {
  //
  //
  //

  bool _onEdge = false;

  //
  //
  //

  @override
  void initState() {
    this.widget.controller.addListener(this._listener);
    super.initState();
  }

  //
  //
  //

  @override
  void dispose() {
    this.widget.controller.removeListener(this._listener);
    super.dispose();
  }

  //
  //
  //

  void _listener() {
    final position = this.widget.controller.position;
    if (position.pixels <= position.minScrollExtent) {
      if (!this._onEdge) {
        this.widget.onEdgeMin?.call();
      }
      this._onEdge = true;
    } else if (position.pixels >= position.maxScrollExtent) {
      if (!this._onEdge) {
        this.widget.onEdgeMax?.call();
      }
      this._onEdge = true;
    } else {
      this._onEdge = false;
    }
  }

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.widget.makeup ?? G.theme.scrollableDefault();
    return Padding(
      padding: makeup.outsidePadding,
      child: VsScrollbar(
        controller: this.widget.controller,
        isAlwaysShown: makeup.isAlwaysShown,
        style: makeup.style,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: this.widget.axis,
          controller: this.widget.controller,
          reverse: this.widget.reverse,
          child: Padding(
            padding: makeup.insidePadding,
            child: this.widget.child,
          ),
        ),
      ),
    );
  }
}
