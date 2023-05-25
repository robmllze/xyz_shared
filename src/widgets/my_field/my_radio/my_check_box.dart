// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyCheckbox extends StatefulWidget {
  //
  //
  //

  final MakeupRadio? makeup;
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
    this.makeup,
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
    final makeup = this.widget.makeup ?? G.theme.radioDefault();
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (makeup.isChildrenBefore) ...[
            makeup.spacer,
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: this.widget.children,
              ),
            ),
          ],
          Consumer(
            builder: (_, final ref, __) {
              final value = this.widget.pValue.watch(ref);
              final enabled = this.widget.pEnabled?.watch(ref) != false;
              switch (this.widget.type) {
                case MyCheckboxType.CHECKBOX:
                  return MyMaterialCheckbox(
                    value: value,
                    makeup: makeup,
                    onChanged: enabled ? (_) => onTap() : null,
                  );
                case MyCheckboxType.RADIO:
                  return MyMaterialRadio(
                    value: value,
                    makeup: makeup,
                    onChanged: enabled ? (_) => onTap() : null,
                  );
              }
            },
          ),
          if (makeup.isChildrenAfter) ...[
            makeup.spacer,
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: this.widget.children,
              ),
            ),
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
      return this.onChanged != null
          ? value == true
              ? this.makeup.selectedColor
              : this.makeup.unselectedBorderColor
          : value == true
              ? this.makeup.disabledSelectedColor
              : this.makeup.disabledUnselectedBorderColor;
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
      return this.onChanged != null
          ? value == true
              ? this.makeup.selectedColor
              : this.makeup.unselectedBorderColor
          : value == true
              ? this.makeup.disabledSelectedColor
              : this.makeup.disabledUnselectedBorderColor;
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
