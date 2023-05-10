// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRadioList<T> extends StatefulWidget {
  //
  //
  //

  final MakeupRadio? makeup;
  final Pod pValue;
  final Pod<bool>? pEnabled;
  final Widget? title;
  final List<T> options;
  final Widget Function(T)? optionBuilder;
  final MyFieldListRadio_SelectMode selectMode;
  final void Function(T option, bool value, List<T> all)? onTap;

  //
  //
  //

  const MyRadioList({
    Key? key,
    this.makeup,
    required this.pValue,
    this.pEnabled,
    this.options = const [],
    this.optionBuilder,
    this.title,
    this.selectMode = MyFieldListRadio_SelectMode.MULTIPLE,
    this.onTap,
  }) : super(key: key);

  //
  //
  //

  @override
  _State<T> createState() => _State<T>();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State<T> extends State<MyRadioList<T>> {
  //
  //
  //

  Future<void> Function(T)? _onTap;
  late final _pValue = this.widget.pValue.toDynamic..value ??= <T>[];
  late final _pEnabled = this.widget.pEnabled;

  //
  //
  //

  @override
  void dispose() {
    this._pValue.disposeIfRequested();
    this._pEnabled?.disposeIfRequested();
    super.dispose();
  }

  //
  //
  //

  @override
  void initState() {
    super.initState();
    switch (this.widget.selectMode) {
      case MyFieldListRadio_SelectMode.MULTIPLE:
        this._onTap = this._onTapMultiple;
        break;
      case MyFieldListRadio_SelectMode.MULTIPLE_OR_NULL:
        this._onTap = this._onTapMultipleOrNull;
        break;
      case MyFieldListRadio_SelectMode.SINGLE:
        this._onTap = this._onTapSingle;
        break;
      case MyFieldListRadio_SelectMode.SINGLE_OR_NULL:
        this._onTap = this._onTapSingleOrNull;
        break;
    }
  }

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.widget.makeup ?? G.theme.radioDefault();
    return MyColumn(
      children: [
        if (this.widget.title != null) ...[
          this.widget.title!,
          wHeight12(),
        ],
        Consumer(
          builder: (_, final ref, __) {
            this._pValue.watch(ref);
            return Wrap(
              direction: Axis.horizontal,
              runSpacing: 10.0.scaled,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: this.widget.options.map((final option) {
                final contains = this._pValue.value.contains(option);
                return MyRadio2(
                  pValue: Pod<bool>.temp(contains),
                  pEnabled: this._pEnabled,
                  makeup: makeup,
                  onTap: (_) async {
                    await this._onTap?.call(option);
                  },
                  children: [
                    Expanded(
                      child: this.widget.optionBuilder?.call(option) ??
                          Text(
                            option.toString(),
                            softWrap: true,
                            style: G.theme.textStyles.p2,
                          ),
                    ),
                  ],
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

  Future<void> _onTapMultiple(T option) async {
    final value0 = this._pValue.value;
    final contains = value0.contains(option);
    if (contains) {
      if (value0.length > 1) {
        await this._pValue.update((final a) => List<T>.of(a)..remove(option));
      }
    } else {
      await this._pValue.update((final a) => List<T>.of(a)..add(option));
    }
    final value1 = (this._pValue.value as List).cast<T>();
    this.widget.onTap?.call(option, !contains, value1);
  }

  //
  //
  //

  Future<void> _onTapMultipleOrNull(T option) async {
    final contains = this._pValue.value.contains(option);
    if (contains) {
      await this._pValue.update((final a) => List<T>.of(a)..remove(option));
    } else {
      await this._pValue.update((final a) => List<T>.of(a)..add(option));
    }
    final value = (this._pValue.value as List).cast<T>();
    this.widget.onTap?.call(option, !contains, value);
  }

  //
  //
  //

  Future<void> _onTapSingle(T option) async {
    final contains = this._pValue.value.contains(option);
    await this._pValue.set(<T>[option]);
    final value = (this._pValue.value as List).cast<T>();
    this.widget.onTap?.call(option, !contains, value);
  }

  //
  //
  //

  Future<void> _onTapSingleOrNull(T option) async {
    final contains = this._pValue.value.contains(option);
    if (contains) {
      await this._pValue.set(<T>[]);
    } else {
      await this._pValue.set(<T>[option]);
    }
    final value = (this._pValue.value as List).cast<T>();
    this.widget.onTap?.call(option, !contains, value);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum MyFieldListRadio_SelectMode {
  SINGLE,
  SINGLE_OR_NULL,
  MULTIPLE,
  MULTIPLE_OR_NULL,
}

MyFieldListRadio_SelectMode? labelToMyFieldListRadioSelectMode(String? label) {
  if (label != null) {
    for (final a in MyFieldListRadio_SelectMode.values) {
      if (label.trim().toUpperCase() == a.name) {
        return a;
      }
    }
  }
  return null;
}
