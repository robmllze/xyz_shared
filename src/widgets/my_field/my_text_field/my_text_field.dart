// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/cupertino.dart' show CupertinoTextSelectionControls;
import 'package:flutter/material.dart';

import '/all.dart';

typedef TMyTextFieldMakeupFilter = MakeupTextField? Function(MyTextFieldEvent);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  parameters: {
    "errorMakeupFilter": "TMyTextFieldMakeupFilter?",
    "disabledErrorMakeupFilter": "TMyTextFieldMakeupFilter?",
    "disabledMakeupFilter": "TMyTextFieldMakeupFilter?",
    "finalMakeupFilter": "TMyTextFieldMakeupFilter?",
    "cursorColor": "Color",
    "decoration": "BoxDecoration?",
    "insidePadding": "EdgeInsets",
    "keyboardType": "TextInputType",
    "maxLines": "int?",
    "outsidePadding": "EdgeInsets",
    "selectionColor": "Color",
    "textAlign": "TextAlign",
    "textStyle": "TextStyle",
    "errorBuilder": "Widget? Function(MyTextFieldEvent)?",
    "hintBuilder": "Widget? Function(MyTextFieldEvent)?",
    "leftWidgetBuilder": "Widget? Function(MyTextFieldEvent)?",
    "rightWidgetBuilder": "Widget? Function(MyTextFieldEvent)?",
    "titleBuilder": "Widget? Function(MyTextFieldEvent)?",
    "inputFormatters": "List<TextInputFormatter>?",
  },
)
class MyTextField extends MyFieldWidget {
  //
  //
  //

  final MakeupTextField? makeup;
  final Pod<String>? pHint;
  final Pod<List<String>>? pAutoFillHints;
  final FocusNode? focusNode;
  final void Function(MyTextFieldEvent)? onChanged;
  final void Function(MyTextFieldEvent)? onChangedDelayed;
  final void Function(MyTextFieldEvent)? onSubmitted;
  final void Function(MyTextFieldEvent)? onTapInside;
  final void Function(MyTextFieldEvent)? onTapOutside;
  final Duration onChangedDelay;
  final bool autofocus;

  //
  //
  //

  const MyTextField({
    super.key,
    this.makeup,
    this.pHint,
    this.pAutoFillHints,
    required super.pValue,
    super.pEnabled,
    super.pErrorText,
    super.pObscured,
    super.pReadOnly,
    super.pTitle,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.onChangedDelay = const Duration(seconds: 2),
    this.onChangedDelayed,
    this.onSubmitted,
    this.onTapInside,
    this.onTapOutside,
  });

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

  late final Pod<bool> _pHasFocus;
  late final _pHint = this.widget.pHint;
  late final _pAutoFillHints = this.widget.pAutoFillHints;
  late final void Function() _removeOnValueChanged;
  //late final _makeup = this.widget.makeup;
  late final _controller = TextEditingController();
  var _baseOffset = 0;
  late final focusNode = this.widget.focusNode ?? FocusNode();
  final _selectionControls = CurrentPlatform.isOsApple
      ? CupertinoTextSelectionControls()
      : MaterialTextSelectionControls();
  late MyTextFieldEvent _event;

  //
  //
  //

  @override
  void initState() {
    this._removeOnValueChanged = this.pValue.addListener(this.onValueChanged);
    if (this.widget.autofocus) this.focusNode.requestFocus();
    this._pHasFocus = Pod<bool>(this.focusNode.hasFocus);
    this.focusNode.addListener(this._onFocusChanged);
    super.initState();
  }

  //
  //
  //

  @override
  void dispose() {
    this._removeOnValueChanged();
    this.focusNode.removeListener(this._onFocusChanged);
    this._pHasFocus.dispose();
    this._controller.dispose();
    this._pHint?.disposeIfRequested();
    this._pAutoFillHints?.disposeIfRequested();
    super.dispose();
  }

  //
  //
  //

  void onValueChanged(final data) {
    final text = data.value?.toString() ?? "";
    final selection = TextSelection.collapsed(offset: text.length);
    this._controller.value = this._controller.value.copyWith(text: text, selection: selection);
  }

  //
  //
  //

  Future<void> _onFocusChanged() async {
    await this._pHasFocus.set(this.focusNode.hasFocus);
  }

  //
  //
  //

  void _onTapOutside(PointerDownEvent event) {
    this.widget.onTapOutside?.call(this._event);
  }

  //
  //
  //

  void _onChanged(dynamic value) async {
    await this.pValue.set(value, shouldExecuteCallbacks: false);
    this._controller.selection = TextSelection.collapsed(offset: this._baseOffset);
    this.widget.onChanged?.call(this._event);
    this._onChangedDebouncer?.call();
  }

  //
  //
  //

  late final _onChangedDebouncer = this.widget.onChangedDelayed != null
      ? Debouncer(
          delay: this.widget.onChangedDelay,
          onWaited: () {
            this.widget.onChangedDelayed!(this._event);
          },
        )
      : null;

  //
  //
  //

  void _onSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    this._baseOffset = selection.baseOffset;
    this.widget.onTapInside?.call(this._event);
  }

  //
  //
  //

  void _onSubmitted(_) {
    this.focusNode.unfocus();
    this.widget.onSubmitted?.call(this._event);
  }

  //
  //
  //

  @override
  Widget build(_) {
    final makeup = this.widget.makeup ?? G.theme.textFieldDefault();
    final cursorWidth = 1.5.scaled;
    final scrollPadding = EdgeInsets.all($20);
    return Consumer(
      builder: (_, final ref, __) {
        final text = super.pValue.watch(ref)?.toString() ?? "";
        final title = super.pTitle?.watch(ref);
        final enabled = super.pEnabled?.watch(ref) ?? true;
        final readOnly = (super.pReadOnly?.watch(ref) ?? false) || !enabled;
        final obscured = super.pObscured?.watch(ref) ?? false;
        final hint = this._pHint?.watch(ref);
        final error = this.pErrorText?.watch(ref);
        final hasError = error != null;
        final hasFocus = this._pHasFocus.watch(ref);
        final autoFillHints = this._pAutoFillHints?.watch(ref) ?? [];
        this._event = MyTextFieldEvent(
          makeup,
          this,
          text,
          hasFocus,
          hasError,
          enabled,
          readOnly,
          obscured,
          hint,
          error,
          autoFillHints,
        );
        var activeMakeup = (enabled
                ? (hasError ? makeup.errorMakeupFilter?.call(this._event) : makeup)
                : (hasError
                    ? makeup.disabledErrorMakeupFilter?.call(this._event)
                    : makeup.disabledMakeupFilter?.call(this._event))) ??
            makeup;
        final activeEvent = this._event.copyWith(makeup: activeMakeup);
        activeMakeup = makeup.finalMakeupFilter?.call(activeEvent) ?? activeMakeup;
        final titleBuilder = activeMakeup.titleBuilder;
        final leftWidgetBuilder = activeMakeup.leftWidgetBuilder;
        final rightWidgetBuilder = activeMakeup.rightWidgetBuilder;
        final hintBuilder = activeMakeup.hintBuilder;
        final errorBuilder = activeMakeup.errorBuilder;
        return GestureDetector(
          onTap: () {
            this.focusNode.requestFocus();
            this.widget.onTapInside?.call(this._event);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) SizedBox(child: titleBuilder?.call(this._event)),
              Container(
                padding: activeMakeup.outsidePadding,
                decoration: activeMakeup.decoration,
                child: Padding(
                  padding: activeMakeup.insidePadding,
                  child: Row(
                    children: [
                      SizedBox(child: leftWidgetBuilder?.call(this._event)),
                      Expanded(
                        child: Padding(
                          padding: activeMakeup.insidePadding,
                          child: Stack(
                            children: [
                              EditableText(
                                inputFormatters: activeMakeup.inputFormatters,
                                autofillHints: autoFillHints,
                                backgroundCursorColor: activeMakeup.cursorColor,
                                controller: this._controller,
                                cursorColor: activeMakeup.cursorColor,
                                cursorWidth: cursorWidth,
                                enableInteractiveSelection: true,
                                focusNode: this.focusNode,
                                keyboardType: activeMakeup.keyboardType,
                                maxLines: activeMakeup.maxLines,
                                obscureText: obscured,
                                onChanged: this._onChanged,
                                onSelectionChanged: this._onSelectionChanged,
                                onTapOutside: this._onTapOutside,
                                onSubmitted: this._onSubmitted,
                                readOnly: readOnly,
                                scrollPadding: scrollPadding,
                                selectionColor: activeMakeup.selectionColor,
                                selectionControls: this._selectionControls,
                                style: activeMakeup.textStyle,
                                textAlign: activeMakeup.textAlign,
                              ),
                              if (hint != null && text.isEmpty)
                                SizedBox(child: hintBuilder?.call(this._event)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(child: rightWidgetBuilder?.call(this._event)),
                    ],
                  ),
                ),
              ),
              if (error != null) SizedBox(child: errorBuilder?.call(this._event)),
            ],
          ),
        );
      },
    );
  }
}
