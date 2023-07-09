// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

part of 'my_screen.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class MyScreenState<T1 extends MyScreen, T2 extends MyRouteConfiguration,
    T3 extends MyScreenLogic<T2>> extends ConsumerState<T1> {
  //
  //
  //

  late final T2 configuration =
      (configurationCasts[T2]?.call(this.widget.configuration) ?? this.widget.configuration) as T2;

  late final _rawLogic = this.widget.createLogic(this.widget, this);
  late T3 logic = this._rawLogic as T3;

  static bool _didRemoveSplashScreen = false;

  static void _removeSplashScreen(_) {
    FlutterNativeSplash.remove();
    _didRemoveSplashScreen = true;
  }

  final _pFacade = Pod<MyFacade?>(null);

  //
  //
  //

  @override
  void initState() {
    // ...
    this._rawLogic.initLogic();

    // Log when screen gets initialized.
    final uri = this.widget.configuration.uri;
    debugLogStart("Initializing $uri");

    // ...
    final key = this.widget.key as UriKey;
    _MyScreenTimer._history.add(_MyScreenTimer.begin(key));

    // ...
    if (_didRemoveSplashScreen == false && this.widget.configuration.uri.toString() != "/blank") {
      WidgetsBinding.instance.addPostFrameCallback(_removeSplashScreen);
    }

    // ...
    super.initState();
  }

  //
  //
  //

  @override
  void dispose() async {
    // Log when screen gets disposed.
    final uri = this.widget.configuration.uri;
    debugLog("Disposing $uri");

    // ...
    final key = this.widget.key as UriKey;
    _MyScreenTimer._history.lastWhere((final l) => l.key == key);

    // ...
    G.pTheme.callbacks.remove(this.widget.key);

    // ...

    super.dispose();

    // ...
    this._rawLogic.dispose();

    // ...
    this._pFacade.dispose();
  }

  //
  //
  //

  /// ...
  @mustCallSuper
  Widget layout(Widget body) {
    final facade = this._pFacade.watch(ref);
    return facade?.draw() ??
        MyAnimatedFade(
          duration: this.widget.makeup.transitionDuration,
          layer2: Container(
            color: this.widget.makeup.backgroundColor,
            child: body,
          ),
        );
  }

  //
  //
  //

  /// ...
  Future<void> showFacade({MyFacade? facade, double pixelRatio = 1.0}) async {
    final image = await G.router.captureScreenImage(pixelRatio: pixelRatio);
    await this._pFacade.set((facade ?? const MyFacade()).copyWith(image: image));
  }

  /// ...
  Future<void> hideFacade() async {
    await this._pFacade.set(null);
  }

  //
  //
  //

  /// ...
  Widget body(BuildContext context);

  //
  //
  //

  /// ...
  Future<void> openDialog(MyDialog dialog) async {
    // Dismiss keyboard.
    FocusScope.of(context).unfocus();
    debugLogStart("Opening dialog ${dialog.runtimeType}");
    dialog.onError ??= (Object? e) async {
      await Future.delayed(const Duration(milliseconds: 500));
      await this.openDialog(
        MyDialogOkay(
          dialogMakeup: G.theme.dialogDefault(),
          title: "Error||error".tr(),
          message: e.toString(),
          labelOkay: "OKAY||okay".tr(),
        ),
      );
    };
    this.setState(() {
      MyScreen.pDialog.set(dialog);
    });
    await dialog.completer.future;
    if (dialog.shouldCloseOnComplete) {
      this.closeDialog();
    }
  }

  //
  //
  //

  /// ...
  Future<void> closeDialog() async {
    if (MyScreen.pDialog.valueAs() != null) {
      debugLog("Closing dialog ${MyScreen.pDialog.value.runtimeType}");
      await Future.delayed(Duration.zero, () async {
        await MyScreen.pDialog.set(null);
      });
      if (this.mounted) {
        this.setState(() {});
      }
    }
  }

  //
  //
  //

  @override
  Widget build(final context) {
    return MyHideKeyboardOnTap(
      child: this.layout(
        this.body(context),
      ),
    );
  }
}
