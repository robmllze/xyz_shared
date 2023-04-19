import 'dart:async';

import 'package:flutter/material.dart';

class CustomScrollBar extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;

  const CustomScrollBar({super.key, required this.scrollController, required this.child});

  @override
  _CustomScrollBarState createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  Timer? _timer;
  bool _isDragging = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 1), () {
      setState(() {
        _isDragging = false;
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    if (!_isDragging) {
      setState(() {
        _isDragging = true;
      });
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          onPointerDown: (_) => _resetTimer(),
          onPointerMove: (_) => _resetTimer(),
          child: widget.child,
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: _isDragging ? 1.0 : 0.0,
          child: Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 8.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: GestureDetector(
                onVerticalDragStart: (_) => _resetTimer(),
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  double offset = details.delta.dy / context.size!.height;
                  widget.scrollController.jumpTo(
                    widget.scrollController.offset +
                        offset * widget.scrollController.position.maxScrollExtent,
                  );
                  _resetTimer();
                },
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
