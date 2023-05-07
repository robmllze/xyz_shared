// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@immutable
class HistoryActivity {
  final Widget child;
  final DateTime createdAt;

  //
  //
  //

  const HistoryActivity({
    required this.child,
    required this.createdAt,
  });
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyHistoryActivityList extends StatelessWidget {
  //
  //
  //

  final List<HistoryActivity> activities;

  //
  //
  //

  const MyHistoryActivityList({
    super.key,
    required this.activities,
  });

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const SizedBox.shrink();
    }

    final activityWidgets = activities.asMap().entries.map((entry) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 4,
            left: -4,
            child: Container(
              height: 9,
              width: 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: G.theme.palette.primary,
              ),
            ),
          ),
          if (entry.key == activities.length - 1)
            Positioned(
              child: Container(
                width: 1,
                height: 4,
                color: G.theme.palette.primary.withOpacity(0.44),
              ),
            ),
          Container(
            decoration: entry.key == activities.length - 1
                ? null
                : BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 1.0,
                        color: G.theme.palette.primary.withOpacity(0.44),
                      ),
                    ),
                  ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  entry.value.child,
                  const SizedBox(height: 7),
                  // Text(
                  //   DateFormat.yMMMMd("en_US").add_jm().format(entry.value.createdAt),
                  //   style: const TextStyle(
                  //     fontSize: 11,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          if (entry.key == 0)
            Positioned(
              child: Container(
                width: 1,
                height: 4,
                color: Colors.white,
              ),
            ),
        ],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        children: activityWidgets,
      ),
    );
  }
}
