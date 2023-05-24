// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyTapDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Size? detectionSize;
  final Size detectionBorder;

  const MyTapDetector({
    super.key,
    this.detectionSize,
    this.detectionBorder = const Size.square(double.maxFinite),
    required this.onTap,
    required this.child,
  });

  @override
  State<MyTapDetector> createState() => _MyTapDetectorState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _MyTapDetectorState extends State<MyTapDetector> {
  Size _childSize = Size.zero;
  @override
  Widget build(_) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: this.widget.detectionSize?.width != null
            ? this.widget.detectionSize!.width
            : this._childSize.width + widget.detectionBorder.width,
        minHeight: this.widget.detectionSize?.height != null
            ? this.widget.detectionSize!.height
            : this._childSize.height + widget.detectionBorder.height,
      ),
      child: Center(
        child: ExpandedHitTestArea(
          detectionBorder: this.widget.detectionBorder,
          onTap: this.widget.onTap,
          child: MyWidgetCalculator(
            child: this.widget.child,
            onPostRender: (final renderBox) {
              this.setState(() {
                this._childSize = renderBox.size;
              });
            },
          ),
        ),
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ExpandedHitTestArea extends SingleChildRenderObjectWidget {
  final VoidCallback? onTap;
  final Size? detectionSize;
  final Size detectionBorder;
  const ExpandedHitTestArea({
    super.key,
    super.child,
    this.detectionSize,
    this.detectionBorder = const Size.square(double.maxFinite),
    this.onTap,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => RenderExpandedHitTestArea(
        onTap: onTap,
        detectionSize: detectionSize,
        detectionBorder: detectionBorder,
      );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class TestGestureArenaMember extends GestureArenaMember {
  TestGestureArenaMember({this.onTap});
  final VoidCallback? onTap;
  @override
  void acceptGesture(int key) => this.onTap?.call();

  @override
  void rejectGesture(int key) {}
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class RenderExpandedHitTestArea extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  final Size? detectionSize;
  final Size detectionBorder;
  RenderExpandedHitTestArea({
    required this.onTap,
    this.detectionSize,
    this.detectionBorder = const Size(8.0, 8.0),
  });
  final VoidCallback? onTap;
  @override
  void performLayout() {
    child!.layout(constraints, parentUsesSize: true);
    size = child!.size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final childParentData = child!.parentData as BoxParentData;
      context.paintChild(child!, childParentData.offset + offset);
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      final member = TestGestureArenaMember(onTap: onTap);
      GestureBinding.instance.gestureArena.add(event.pointer, member);
    } else if (event is PointerUpEvent) {
      GestureBinding.instance.gestureArena.sweep(event.pointer);
    }
  }

  @override
  bool hitTest(HitTestResult result, {required Offset position}) {
    final xw = this.detectionBorder.width;
    final xh = this.detectionBorder.height;
    final dw = detectionSize?.width;
    final dh = detectionSize?.height;
    final width = size.width;
    final height = size.height;
    final w0 = xw + width;
    final w1 = dw != null ? (w0 > dw ? dw : w0) : w0;
    final tw = xw - width + w1;
    final h0 = xh + height;
    final h1 = dh != null ? (h0 > dh ? dh : h0) : h0;
    final th = xh - height + h1;
    if (Rect.fromLTRB(-tw, -th, w1, h1).contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }
}
