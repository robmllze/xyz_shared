// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Xyz Shared
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

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

  final MakeupScrollable makeup;
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
    required this.makeup,
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
    return Padding(
      padding: this.widget.makeup.outsidePadding,
      child: VsScrollbar(
        controller: this.widget.controller,
        isAlwaysShown: this.widget.makeup.isAlwaysShown,
        style: this.widget.makeup.style,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: this.widget.axis,
          controller: this.widget.controller,
          reverse: this.widget.reverse,
          child: Padding(
            padding: this.widget.makeup.insidePadding,
            child: this.widget.child,
          ),
        ),
      ),
    );
  }
}
