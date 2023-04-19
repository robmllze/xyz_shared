// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKinect
//
// Copyright Ⓒ 2023-2025, N Sanchez Medical Research Corporation
// See LICENSE.txt for more information
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyNavigationBar extends ConsumerStatefulWidget {
  //
  //
  //

  final List<MyNavigationBarItem> items;
  final Pod<ValueKey?> pValue;

  //
  //
  //

  const MyNavigationBar({
    Key? key,
    required this.items,
    required this.pValue,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends ConsumerState<MyNavigationBar> {
  @override
  Widget build(_) {
    final keySelected = this.widget.pValue.watch(this.ref);
    final items1 = <Widget>[];
    for (var n = 0; n < this.widget.items.length; n++) {
      final item = this.widget.items[n];
      final keyItem = item.key;
      final isSelected = keyItem == keySelected;
      items1.add(
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            await this.widget.pValue.set(keyItem);
            item.onTap?.call();
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                width: 52.0.scaled,
                height: 52.0.scaled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (isSelected ? item.selectedBuilder : item.unselectedBuilder)?.call(item.data) ??
                        const SizedBox(),
                    if (item.label != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0.scaled),
                        child: SizedBox(
                          height: 16.0.scaled,
                          child: Center(
                            child: Text(
                              item.label!,
                              style: (item.isSelectable && isSelected
                                      ? G.theme.textStyles.p2.copyWith(
                                          color: G.theme.palette.primary,
                                        )
                                      : G.theme.textStyles.p2.copyWith(
                                          color: G.theme.palette.neutral,
                                        ))
                                  .copyWith(fontSize: 7.0.scaled),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              item.indicatorBuilder?.call(item.data) ?? const SizedBox(),
            ],
          ),
        ),
      );
    }
    final itemCount = items1.length;
    final screenWidth = G.appScreen.size.width;
    var k = (screenWidth - (52.0.scaled * itemCount) - (2.0 * 8.0.scaled)) / (1.0 + itemCount);
    if (k < 0.0) k = 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.scaled),
      child: Wrap(
        spacing: k,
        alignment: WrapAlignment.spaceBetween,
        children: [...items1],
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyNavigationBarItem<T> {
  //
  //
  //

  final ValueKey key;
  final Widget? Function(Widget?)? indicatorBuilder, unselectedBuilder, selectedBuilder;
  final T? data;
  final String? label;
  final void Function()? onTap;
  final bool isSelectable;

  //
  //
  //

  const MyNavigationBarItem({
    required this.key,
    this.unselectedBuilder,
    this.selectedBuilder,
    this.indicatorBuilder,
    this.data,
    this.label,
    this.onTap,
    this.isSelectable = true,
  });
}
