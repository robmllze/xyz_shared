// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Xyz Shared
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyScreenBuilder {
  //
  //
  //

  // Singleton.
  static final instance = MyScreenBuilder._();
  MyScreenBuilder._();

  //
  //
  //

  SuperScreen? _screenCurrent, _screenPrevious;
  SuperScreen? get screenCurrent => this._screenCurrent;
  SuperScreen? get screenPrevious => this._screenPrevious;

  //
  //
  //

  bool isAccessibleOnlyIfSignedInAndVerified(String location) {
    for (final a in ([
      ...LOCATIONS_ACCESSIBLE_ONLY_IF_SIGNED_IN_AND_VERIFIED,
      ...LOCATIONS_ACCESSIBLE,
    ]..removeWhere((final b) => LOCATIONS_NOT_REDIRECTABLE.contains(b)))) {
      if (locationToExp(a).hasMatch(location)) return true;
    }
    return false;
  }

  //
  //
  //

  bool isAccessibleOnlyIfSignedIn(String location) {
    for (final a in ([
      ...LOCATIONS_ACCESSIBLE_ONLY_IF_SIGNED_IN,
      ...LOCATIONS_ACCESSIBLE,
    ]..removeWhere((final b) => LOCATIONS_NOT_REDIRECTABLE.contains(b)))) {
      if (locationToExp(a).hasMatch(location)) return true;
    }
    return false;
  }

  //
  //
  //

  bool isAccessibleOnlyIfSignedOut(String location) {
    for (final a in ([
      ...LOCATIONS_ACCESSIBLE_ONLY_IF_SIGNED_OUT,
      ...LOCATIONS_ACCESSIBLE,
    ]..removeWhere((final b) => LOCATIONS_NOT_REDIRECTABLE.contains(b)))) {
      if (locationToExp(a).hasMatch(location)) return true;
    }
    return false;
  }

  //
  //
  //

  Future<SuperScreen?> build(MyRouteConfiguration? configuration) async {
    // Returning `null` indicates to stay on current screen.
    if (configuration == null) return null;

    // Set the previous screen.
    this._screenPrevious = this._screenCurrent;

    // Set the current screen.
    this._screenCurrent = configurationToScreen(configuration);

    // Returning `null` indicates to stay on current screen.
    if (this._screenCurrent == this._screenPrevious) return null;

    // Call previous screen's on-exit callback.
    await this._screenPrevious?.onScreenPushExit();

    // Call current screen's on-enter callback.
    await this._screenCurrent?.onScreenPushEnter();

    // Pop the current dialog if there is one.
    Future.delayed(Duration.zero, () {
      SuperScreen.pDialog.set(null);
    });

    // Return the current screen.
    return this._screenCurrent;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

RegExp locationToExp(String location) {
  // Lazy: (\/LOCATION)([\?\/].*)?
  // Strict: (\/LOCATION)(((\?[\w%\.-]+\=[\w%\.-]+)(\&[\w%\.-]+\=[\w%\.-]+)+)|(\?[\w%\.-]+\=[\w%\.-]+))?
  return RegExp(
    r"^(\" + location + r")([\?\/].*)?$",
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

SuperScreen? configurationToScreen(MyRouteConfiguration configuration) {
  for (final screenMaker in SCREEN_MAKERS) {
    final screen = screenMaker.call(
      configuration,
      G.isVerified,
      G.isSignedIn,
      G.isSignedOut,
    );
    if (screen != null) {
      return screen;
    }
  }
  return null;
}
