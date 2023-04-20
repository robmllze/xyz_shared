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
    "errorMakeupFilter": "TMakeupFilter?",
    "disabledErrorMakeupFilter": "TMakeupFilter?",
    "disabledMakeupFilter": "TMakeupFilter?",
    "finalMakeupFilter": "TMakeupFilter?",
    "cursorColor": "Color",
    "decoration": "BoxDecoration?",
    "insidePadding": "EdgeInsets",
    "keyboardType": "TextInputType",
    "maxLines": "int?",
    "outsidePadding": "EdgeInsets",
    "selectionColor": "Color",
    "textAlign": "TextAlign",
    "textStyle": "TextStyle",
    "errorBuilder": "Widget? Function(TextFieldEvent)?",
    "hintBuilder": "Widget? Function(TextFieldEvent)?",
    "leftWidgetBuilder": "Widget? Function(TextFieldEvent)?",
    "rightWidgetBuilder": "Widget? Function(TextFieldEvent)?",
    "titleBuilder": "Widget? Function(TextFieldEvent)?",
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
  final void Function(TextFieldEvent)? onChanged;
  final void Function(TextFieldEvent)? onChangedDelayed;
  final void Function(TextFieldEvent)? onTapInside;
  final void Function(TextFieldEvent)? onTapOutside;
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
    super.pError,
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
  late TextFieldEvent _event;

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

  void _onSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    this._baseOffset = selection.baseOffset;
    this.widget.onTapInside?.call(this._event);
  }

  //
  //
  //

  @override
  Widget build(_) {
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
        this._event = TextFieldEvent(
          this._makeup,
          this.widget,
          this,
          hasFocus,
          hasError,
          enabled,
          readOnly,
        );
        var activeMakeup = (enabled
                ? hasError
                    ? this._makeup.errorMakeupFilter?.call(this._event)
                    : this._makeup
                : hasError
                    ? this._makeup.disabledErrorMakeupFilter?.call(this._event)
                    : this._makeup.disabledMakeupFilter?.call(this._event)) ??
            this._makeup;
        final activeEvent = this._event.copyWith(makeup: activeMakeup);
        activeMakeup = this._makeup.finalMakeupFilter?.call(activeEvent) ?? activeMakeup;
        final titleBuilder = activeMakeup.titleBuilder;
        final leftWidgetBuilder = activeMakeup.leftWidgetBuilder;
        final rightWidgetBuilder = activeMakeup.rightWidgetBuilder;
        final hintBuilder = activeMakeup.hintBuilder;
        final errorBuilder = activeMakeup.errorBuilder;
        return GestureDetector(
          onTap: () {
            this._focusNode.requestFocus();
            this.widget.onTapInside?.call(this._event);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enabled: ${enabled}"),
              Text("ReadOnly: ${readOnly}"),
              if (title != null && titleBuilder != null)
                titleBuilder(this._event) ?? const SizedBox.shrink(),
              Container(
                padding: activeMakeup.outsidePadding,
                decoration: activeMakeup.decoration,
                child: Padding(
                  padding: activeMakeup.insidePadding,
                  child: Row(
                    children: [
                      if (leftWidgetBuilder != null)
                        leftWidgetBuilder(this._event) ?? const SizedBox.shrink(),
                      Expanded(
                        child: Stack(
                          children: [
                            EditableText(
                              backgroundCursorColor: activeMakeup.cursorColor,
                              controller: this._controller,
                              cursorColor: activeMakeup.cursorColor,
                              cursorWidth: cursorWidth,
                              enableInteractiveSelection: true,
                              focusNode: this._focusNode,
                              keyboardType: activeMakeup.keyboardType,
                              maxLines: activeMakeup.maxLines,
                              obscureText: obscured,
                              onChanged: this._onChanged,
                              onSelectionChanged: this._onSelectionChanged,
                              onTapOutside: this._onTapOutside,
                              readOnly: readOnly,
                              scrollPadding: scrollPadding,
                              selectionColor: activeMakeup.selectionColor,
                              selectionControls: this._selectionControls,
                              style: activeMakeup.textStyle,
                              textAlign: activeMakeup.textAlign,
                            ),
                            if (hint != null && hintBuilder != null && !hasFocus)
                              hintBuilder(this._event) ?? const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      if (rightWidgetBuilder != null)
                        rightWidgetBuilder(this._event) ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              if (error != null && errorBuilder != null)
                errorBuilder(this._event) ?? const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef TMakeupFilter = MakeupTextField? Function(TextFieldEvent);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class TextFieldEvent {
  //
  //
  //

  final MakeupTextField makeup;
  final MyTextField widget;
  final MyTextFieldState state;
  final bool hasFocus;
  final bool hasError;
  final bool enabled;
  final bool readOnly;

  //
  //
  //

  TextFieldEvent(
    this.makeup,
    this.widget,
    this.state,
    this.hasFocus,
    this.hasError,
    this.enabled,
    this.readOnly,
  );

  //
  //
  //

  TextFieldEvent copyWith({
    MakeupTextField? makeup,
    MyTextField? widget,
    MyTextFieldState? state,
    bool? hasFocus,
    bool? hasError,
    bool? enabled,
    bool? readOnly,
  }) {
    return TextFieldEvent(
      makeup ?? this.makeup,
      widget ?? this.widget,
      state ?? this.state,
      hasFocus ?? this.hasFocus,
      hasError ?? this.hasError,
      enabled ?? this.enabled,
      readOnly ?? this.readOnly,
    );
  }
}
