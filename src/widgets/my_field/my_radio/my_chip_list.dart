// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyFieldChipList extends StatefulWidget {
  //
  //
  //

  final MakeupChip makeup;
  final Pod<List<String>> pValue;
  final Pod<bool>? pEnabled;
  final Widget? title;
  final List<String> options;
  final MyFieldChipList_SelectMode selectMode;
  final void Function(String option, bool value, List<String> all)? onPressed;

  //
  //
  //

  const MyFieldChipList({
    Key? key,
    required this.pValue,
    this.pEnabled,
    required this.makeup,
    this.options = const [],
    this.title,
    this.selectMode = MyFieldChipList_SelectMode.MULTIPLE,
    this.onPressed,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State<T> extends State<MyFieldChipList> {
  //
  //
  //

  Function(String)? _onTap;

  //
  //
  //

  @override
  void initState() {
    super.initState();
    switch (this.widget.selectMode) {
      case MyFieldChipList_SelectMode.MULTIPLE:
        this._onTap = this._onTapMultiple;
        break;
      case MyFieldChipList_SelectMode.MULTIPLE_OR_NULL:
        this._onTap = this._onTapMultipleOrNull;
        break;
      case MyFieldChipList_SelectMode.SINGLE:
        this._onTap = this._onTapSingle;
        break;
      case MyFieldChipList_SelectMode.SINGLE_OR_NULL:
        this._onTap = this._onTapSingleOrNull;
        break;
    }
  }

  //
  //
  //

  @override
  Widget build(_) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (this.widget.title != null) ...[
          this.widget.title!,
          wHeight16(),
        ],
        Consumer(
          builder: (_, final ref, __) {
            final value = this.widget.pValue.watch(ref);
            final enabled = this.widget.pEnabled?.watch(ref) != false;
            final makeup = this.widget.makeup;
            return Wrap(
              spacing: $12,
              runSpacing: $12,
              children: this.widget.options.map((final label) {
                final selected = value.contains(label);
                return MyChip(
                  makeup: makeup,
                  label: label,
                  selected: selected,
                  enabled: enabled,
                  onTap: () {
                    if (this.widget.pEnabled?.valueAs() != false) {
                      this._onTap?.call(label);
                    }
                  },
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  //
  //
  //

  void _onTapMultiple(String option) {
    final value = this.widget.pValue.value.contains(option);
    if (value) {
      if (this.widget.pValue.value.length > 1) {
        this.widget.pValue.update((final a) => List.of(a)..remove(option));
      }
    } else {
      this.widget.pValue.update((final a) => List.of(a)..add(option));
    }
    this.widget.onPressed?.call(option, !value, this.widget.pValue.valueAs());
  }

  //
  //
  //

  void _onTapMultipleOrNull(String option) {
    final value = this.widget.pValue.value.contains(option);
    if (value) {
      this.widget.pValue.update((final a) => List.of(a)..remove(option));
    } else {
      this.widget.pValue.update((final a) => List.of(a)..add(option));
    }
    this.widget.onPressed?.call(option, !value, this.widget.pValue.valueAs());
  }

  //
  //
  //

  void _onTapSingle(String option) {
    final value = this.widget.pValue.value.contains(option);
    this.widget.pValue.set([option], equals: equalsList);
    this.widget.onPressed?.call(option, !value, this.widget.pValue.valueAs());
  }

  //
  //
  //

  void _onTapSingleOrNull(String option) {
    final value = this.widget.pValue.value.contains(option);
    if (value) {
      this.widget.pValue.set([], equals: equalsList);
    } else {
      this.widget.pValue.set([option], equals: equalsList);
    }
    this.widget.onPressed?.call(option, !value, this.widget.pValue.valueAs());
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum MyFieldChipList_SelectMode {
  SINGLE,
  SINGLE_OR_NULL,
  MULTIPLE,
  MULTIPLE_OR_NULL,
}

MyFieldChipList_SelectMode? labelToMyFieldListTagSelectMode(String? label) {
  if (label != null) {
    for (final a in MyFieldChipList_SelectMode.values) {
      if (label.trim().toUpperCase() == a.name) {
        return a;
      }
    }
  }
  return null;
}
