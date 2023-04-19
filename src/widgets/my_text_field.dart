import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/all.dart';

@GenerateMakeups(
  names: {},
  parameters: {
    "cursorColor": "Color",
    "decoration": "Decoration?",
    "disabledMakeup": "MakeupTextField?",
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
  },
)
class MyTextField extends StatefulWidget {
  final MakeupTextField makeup;
  final String hintText;
  final Pod pValue;
  final Pod? pTitle;
  final Pod<bool>? pEnabled;
  final Pod<bool>? pReadOnly;
  final Pod<bool>? pObscured;
  final FocusNode? focusNode;
  final void Function(dynamic)? onChanged;
  final void Function(dynamic)? onChangedDelayed;
  final void Function(dynamic)? onTapInside;
  final void Function(dynamic)? onTapOutside;
  final Duration onChangedDelay;

  const MyTextField({
    super.key,
    required this.makeup,
    this.hintText = "",
    required this.pValue,
    this.pTitle,
    this.pEnabled,
    this.pReadOnly,
    this.pObscured,
    this.focusNode,
    this.onChanged,
    this.onChangedDelayed,
    this.onChangedDelay = const Duration(milliseconds: 500),
    this.onTapInside,
    this.onTapOutside,
  });

  @override
  _State createState() => _State();
}

class _State extends State<MyTextField> {
  //
  //
  //

  late final _pValue = this.widget.pValue;
  late final _pTitle = this.widget.pTitle;
  late final _pEnabled = this.widget.pEnabled;
  late final _pReadOnly = this.widget.pReadOnly;
  late final _pObscured = this.widget.pObscured;
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
            this.widget.onChangedDelayed!(this._pValue.value);
          },
        )
      : null;
  //
  //
  //

  @override
  void initState() {
    this._addCallback();
    super.initState();
  }

  //
  //
  //

  void _addCallback() {
    this._removeCallback = this._pValue.addListener((final data) async {
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
    this._pValue.disposeIfRequested();
    this._pEnabled?.disposeIfRequested();
    this._pReadOnly?.disposeIfRequested();
    this._pObscured?.disposeIfRequested();
    this._pTitle?.disposeIfRequested();
    this._controller.dispose();
    super.dispose();
  }

  //
  //
  //

  void _onTapOutside(PointerDownEvent event) {
    this.widget.onTapOutside?.call(this._pValue.value);
  }

  //
  //
  //

  void _onChanged(dynamic value) async {
    await this._pValue.set(value, shouldExecuteCallbacks: false);
    this._controller.selection = TextSelection.collapsed(offset: this._baseOffset);
    this.widget.onChanged?.call(value);
    this._onChangedDebouncer?.call();
  }

  //
  //
  //

  void _onSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    this._baseOffset = selection.baseOffset;
    this.widget.onTapInside?.call(this._pValue.value);
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
        this._pValue.watch(ref);
        final title = this._pTitle?.watch(ref);
        final enabled = this._pEnabled?.watch(ref) ?? true;
        final readOnly0 = this._pReadOnly?.watch(ref) ?? false;
        final readOnly1 = readOnly0 || !enabled;
        final obscured = this._pObscured?.watch(ref) ?? false;
        final makeup = enabled ? this._makeup : this._makeup.disabledMakeup ?? this._makeup;
        return GestureDetector(
          onTap: () {
            this._focusNode.requestFocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null && makeup.titleBuilder != null) makeup.titleBuilder!(this.widget),
              Container(
                padding: makeup.outsidePadding,
                decoration: makeup.decoration,
                child: Padding(
                  padding: makeup.insidePadding,
                  child: Row(
                    children: [
                      if (makeup.leftWidgetBuilder != null) makeup.leftWidgetBuilder!(this.widget),
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
                          readOnly: readOnly1,
                          scrollPadding: scrollPadding,
                          selectionColor: makeup.selectionColor,
                          selectionControls: this._selectionControls,
                          style: makeup.textStyle,
                          textAlign: makeup.textAlign,
                        ),
                      ),
                      if (makeup.rightWidgetBuilder != null)
                        makeup.rightWidgetBuilder!(this.widget),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
