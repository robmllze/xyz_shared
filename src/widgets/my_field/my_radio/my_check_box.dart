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

class MyCheckbox extends StatefulWidget {
  //
  //
  //

  final MakeupRadio makeup;
  final Pod<bool> pValue;
  final Pod<bool>? pEnabled;
  final List<Widget> children;
  final void Function(bool)? onTap;
  final MyCheckboxType type;

  //
  //
  //

  const MyCheckbox({
    Key? key,
    required this.makeup,
    required this.pValue,
    this.pEnabled,
    this.children = const [],
    this.onTap,
    this.type = MyCheckboxType.CHECKBOX,
  }) : super(key: key);

  //
  //
  //

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum MyCheckboxType {
  CHECKBOX,
  RADIO,
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends State<MyCheckbox> {
  //
  //
  //

  @override
  Widget build(_) {
    void onTap() {
      final enabled = this.widget.pEnabled?.valueAs() != false;
      if (enabled) {
        final a = !this.widget.pValue.valueAs();
        this.widget.pValue.set(a);
        this.widget.onTap?.call(a);
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: onTap,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (this.widget.makeup.isChildrenBefore) ...[
            ...this.widget.children,
            this.widget.makeup.spacer,
          ],
          Consumer(
            builder: (_, final ref, __) {
              final value = this.widget.pValue.watch(ref);
              final enabled = this.widget.pEnabled?.watch(ref) != false;
              switch (this.widget.type) {
                case MyCheckboxType.CHECKBOX:
                  return MyMaterialCheckbox(
                    value: value,
                    makeup: this.widget.makeup,
                    onChanged: enabled ? (_) => onTap() : null,
                  );
                case MyCheckboxType.RADIO:
                  return MyMaterialRadio(
                    value: value,
                    makeup: this.widget.makeup,
                    onChanged: enabled ? (_) => onTap() : null,
                  );
              }
            },
          ),
          if (this.widget.makeup.isChildrenAfter) ...[
            this.widget.makeup.spacer,
            ...this.widget.children,
          ],
        ],
      ),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@visibleForTesting
class MyMaterialCheckbox extends StatelessWidget {
  //
  //
  //

  final MakeupRadio makeup;
  final bool? value;
  final void Function(bool?)? onChanged;

  //
  //
  //

  const MyMaterialCheckbox({
    required this.makeup,
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final fillColor = MaterialStateProperty.resolveWith<Color>((_) {
      return this.onChanged != null ? this.makeup.selectedColor : this.makeup.disabledSelectedColor;
    });
    final overlayColor = MaterialStateProperty.resolveWith<Color>((_) => Colors.transparent);
    final checkbox = Checkbox(
      value: value,
      onChanged: this.onChanged,
      fillColor: fillColor,
      overlayColor: overlayColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
    );
    return SizedBox.square(
      dimension: this.makeup.size,
      child: checkbox,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@visibleForTesting
class MyMaterialRadio extends StatelessWidget {
  //
  //
  //

  final MakeupRadio makeup;
  final bool? value;
  final void Function(bool?)? onChanged;

  //
  //
  //

  const MyMaterialRadio({
    required this.makeup,
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  //
  //
  //

  @override
  Widget build(_) {
    final fillColor = MaterialStateProperty.resolveWith<Color>((_) {
      return this.onChanged != null ? this.makeup.selectedColor : this.makeup.disabledSelectedColor;
    });
    final overlayColor = MaterialStateProperty.resolveWith<Color>((_) => Colors.transparent);
    final radio = Radio<bool?>(
      value: true,
      onChanged: this.onChanged,
      groupValue: value,
      fillColor: fillColor,
      overlayColor: overlayColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
    );
    return SizedBox.square(
      dimension: this.makeup.size,
      child: radio,
    );
  }
}
