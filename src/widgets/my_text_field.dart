// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Xyz Shared
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "cursorColor": "Color",
    "decoration": "Decoration?",
    "disabledErrorMakeup": "MakeupTextField?",
    "disabledMakeup": "MakeupTextField?",
    "errorBuilder": "Widget Function(MyTextField)?",
    "errorMakeup": "MakeupTextField?",
    "hintBuilder": "Widget Function(MyTextField)?",
    "insidePadding": "EdgeInsets",
    "keyboardType": "TextInputType",
    "leftWidgetBuilder": "Widget Function(MyTextField)?",
    "maxLines": "int?",
    "outsidePadding": "EdgeInsets",
    "rightWidgetBuilder": "Widget Function(MyTextField)?",
    "selectionColor": "Color",
    "textAlign": "TextAlign",
    "textStyle": "TextStyle",
    "titleBuilder": "Widget Function(MyTextField)?",
    "makeupFilterBuilder":
        "MakeupTextField Function(MakeupTextField, MyTextField, MyTextFieldState)?",
  },
)

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyTextField extends MyFieldWidget {
  //
  //
  //

  final MakeupTextField makeup;
  final Pod<String>? pHint;
  final FocusNode? focusNode;
  final void Function(dynamic)? onChanged;
  final void Function(dynamic)? onChangedDelayed;
  final void Function(dynamic)? onTapInside;
  final void Function(dynamic)? onTapOutside;
  final Duration onChangedDelay;
  final bool autofocus;

  //
  //
  //

  const MyTextField({
    super.key,
    required this.makeup,
    this.pHint,
    required super.pValue,
    super.pTitle,
    super.pEnabled,
    super.pReadOnly,
    super.pObscured,
    this.focusNode,
    this.onChanged,
    this.onChangedDelayed,
    this.onChangedDelay = const Duration(milliseconds: 500),
    this.onTapInside,
    this.onTapOutside,
    this.autofocus = false,
  });

  //
  //
  //

  String get text => this.pValue.value?.toString() ?? "";

  //
  //
  //

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyTextFieldState extends MyFieldState<MyTextField> {
  //
  //
  //

  late final _pHint = this.widget.pHint;
  late final void Function() _removeCallback;
  late final _makeup = this.widget.makeup;
  late final _controller = TextEditingController();
  var _baseOffset = 0;
  late final _focusNode = this.widget.focusNode ?? FocusNode();
  final _selectionControls = CurrentPlatform.isOsApple
      ? CupertinoTextSelectionControls()
      : MaterialTextSelectionControls();

  late final _onChangedDebouncer = this.widget.onChangedDelayed != null
      ? Debouncer(
          delay: this.widget.onChangedDelay,
          onWaited: () {
            this.widget.onChangedDelayed!(this.pValue.value);
          },
        )
      : null;
  //
  //
  //

  @override
  void initState() {
    this._addCallback();
    if (this.widget.autofocus) {
      this._focusNode.requestFocus();
    }
    super.initState();
  }

  //
  //
  //

  void _addCallback() {
    this._removeCallback = this.pValue.addListener((final data) async {
      final text = data.value?.toString() ?? "";
      this._controller.value = this._controller.value.copyWith(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          );
    });
  }

  //
  //
  //

  @override
  void dispose() {
    this._removeCallback();
    this._pHint?.disposeIfRequested();
    this._controller.dispose();
    super.dispose();
  }

  //
  //
  //

  void _onTapOutside(PointerDownEvent event) {
    this.widget.onTapOutside?.call(this.pValue.value);
  }

  //
  //
  //

  void _onChanged(dynamic value) async {
    await this.pValue.set(value, shouldExecuteCallbacks: false);
    this._controller.selection = TextSelection.collapsed(offset: this._baseOffset);
    this.widget.onChanged?.call(value);
    this._onChangedDebouncer?.call();
  }

  //
  //
  //

  void _onSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    this._baseOffset = selection.baseOffset;
    this.widget.onTapInside?.call(this.pValue.value);
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    final cursorWidth = 1.5.scaled;
    final scrollPadding = EdgeInsets.all($20);
    return Consumer(
      builder: (_, final ref, __) {
        this.pValue.watch(ref);
        final title = this.pTitle?.watch(ref);
        final enabled = this.pEnabled?.watch(ref) ?? true;
        final readOnly = (this.pReadOnly?.watch(ref) ?? false) || !enabled;
        final obscured = this.pObscured?.watch(ref) ?? false;
        final hint = this._pHint?.watch(ref);
        final error = this.pError?.watch(ref);
        final hasError = error != null;
        final hasFocus = this._focusNode.hasFocus;
        var makeup = (enabled
                ? hasError
                    ? this._makeup.errorMakeup
                    : this._makeup
                : hasError
                    ? this._makeup.disabledErrorMakeup
                    : this._makeup.disabledMakeup) ??
            this._makeup;
        final makeupFilterBuilder = this._makeup.makeupFilterBuilder;
        if (makeupFilterBuilder != null) {
          makeup = makeupFilterBuilder(makeup, this.widget, this);
        }
        final titleBuilder = makeup.titleBuilder;
        final leftWidgetBuilder = makeup.leftWidgetBuilder;
        final rightWidgetBuilder = makeup.rightWidgetBuilder;
        final hintBuilder = makeup.hintBuilder;
        final errorBuilder = makeup.errorBuilder;
        return GestureDetector(
          onTap: () {
            this._focusNode.requestFocus();
            this.widget.onTapInside?.call(this.pValue.value);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null && titleBuilder != null) titleBuilder(this.widget),
              Container(
                padding: makeup.outsidePadding,
                decoration: makeup.decoration,
                child: Padding(
                  padding: makeup.insidePadding,
                  child: Row(
                    children: [
                      if (leftWidgetBuilder != null) leftWidgetBuilder(this.widget),
                      Stack(
                        children: [
                          Expanded(
                            child: EditableText(
                              backgroundCursorColor: makeup.cursorColor,
                              controller: this._controller,
                              cursorColor: makeup.cursorColor,
                              cursorWidth: cursorWidth,
                              enableInteractiveSelection: true,
                              focusNode: this._focusNode,
                              keyboardType: makeup.keyboardType,
                              maxLines: makeup.maxLines,
                              obscureText: obscured,
                              onChanged: this._onChanged,
                              onSelectionChanged: this._onSelectionChanged,
                              onTapOutside: this._onTapOutside,
                              readOnly: readOnly,
                              scrollPadding: scrollPadding,
                              selectionColor: makeup.selectionColor,
                              selectionControls: this._selectionControls,
                              style: makeup.textStyle,
                              textAlign: makeup.textAlign,
                            ),
                          ),
                          if (hint != null && hintBuilder != null && !hasFocus)
                            hintBuilder(this.widget),
                        ],
                      ),
                      if (rightWidgetBuilder != null) rightWidgetBuilder(this.widget),
                    ],
                  ),
                ),
              ),
              if (error != null && errorBuilder != null) errorBuilder(this.widget),
            ],
          ),
        );
      },
    );
  }
}
