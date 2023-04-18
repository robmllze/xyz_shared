// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
class MyIndentedJson extends StatelessWidget {
  //
  //
  //

  final Map data;
  final TextStyle? style;

  //
  //
  //

  const MyIndentedJson({
    super.key,
    required this.data,
    this.style,
  });

  //
  //
  //

  static String _indent(int level) => "  " * level;

  //
  //
  //

  Widget _buildTree(dynamic data, [int level = 0]) {
    final children = <Widget>[];
    if (data is Map) {
      for (final entry in data.entries) {
        children.add(
          Text(
            "${_indent(level)}${entry.key}:",
            style: style?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
        children.add(_buildTree(entry.value, level + 1));
      }
    } else if (data is List) {
      for (final item in data) {
        children.add(_buildTree(item, level + 1));
      }
    } else {
      children.add(
        Text(
          "${_indent(level)}$data",
          style: style?.copyWith(fontWeight: FontWeight.normal),
        ),
      );
    }
    return Column(children: children);
  }

  //
  //
  //

  @override
  Widget build(_) => this._buildTree(this.data);
}
