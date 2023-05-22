// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_facade.dart';

// **************************************************************************
// ScreenAccessGenerator
// **************************************************************************

// ignore_for_file: dead_code
// ignore_for_file: unused_element

// **************************************************************************

const _L = "screens.ScreenFacade";
const _SEGMENT = "facade";
const _LOCATION = "/$_SEGMENT";
const _NAME_SCREEN_CLASS = "ScreenFacade";

extension _ScreenTrExtension on String {
  String screenTr([Map<dynamic, dynamic> args = const {}]) {
    final segments = this.split("||");
    final length = segments.length;
    String fallback, path;
    if (length == 1) {
      fallback = this;
      path = "$_L.${this.trim()}";
    } else {
      fallback = segments[0];
      path = "$_L.${segments[1].trim()}";
    }
    final translated = path.translate<String>(args, fallback) ?? fallback;
    return translated;
  }
}

// **************************************************************************

const LOCATION_NOT_REDIRECTABLE_FACADE = [_LOCATION];
const LOCATION_ACCESSIBLE_FACADE = [_LOCATION];
const LOCATION_ACCESSIBLE_ONLY_IF_SIGNED_IN_AND_VERIFIED_FACADE = [];
const LOCATION_ACCESSIBLE_ONLY_IF_SIGNED_IN_FACADE = [];
const LOCATION_ACCESSIBLE_ONLY_IF_SIGNED_OUT_FACADE = [];

final castScreenFacadeConfiguration = Map<Type,
    MyRouteConfiguration Function(MyRouteConfiguration)>.unmodifiable({
  ScreenFacadeConfiguration: (MyRouteConfiguration a) =>
      ScreenFacadeConfiguration.from(a)
});

MyScreen? makerScreenFacade(
  MyRouteConfiguration configuration,
  bool isSignedInAndVerified,
  bool isSignedIn,
  bool isSignedOut,
) {
  if ((false && !isSignedInAndVerified) ||
      (false && !isSignedIn) ||
      (false && !isSignedOut)) {
    return null;
  }
  if (configuration is ScreenFacadeConfiguration ||
      RegExp(
        r"^(" + _LOCATION + r")([?/].*)?$",
      ).hasMatch(
        Uri.decodeComponent(
          configuration.uri.toString(),
        ),
      )) {
    return ScreenFacade(configuration);
  }
  return null;
}
// **************************************************************************

class ScreenFacadeConfiguration extends MyRouteConfiguration {
  //
  //
  //

  // Some information.

  static const LOCATION = _LOCATION;
  static const L = _L;
  static const NAME_SCREEN_CLASS = _NAME_SCREEN_CLASS;

  // Internal parameters.

  /// Key corresponding to the value `capturedScreenImage`
  static const K_CAPTURED_SCREEN_IMAGE = "captured_screen_image";

  /// Returns the **internal parameter** with the key `captured_screen_image`
  /// or [K_CAPTURED_SCREEN_IMAGE].
  ui.Image get capturedScreenImage =>
      super.arguments<ui.Image>(K_CAPTURED_SCREEN_IMAGE)!;

  /// Creates a new configuration object for [ScreenFacade]
  /// that can be passed to [G.router] to route to the screen with the applied
  /// configuration.
  ///
  /// Use a unique [key] to allow [G.router] to push multiple instances of
  /// [ScreenFacade] with different configurations.
  ScreenFacadeConfiguration({
    String? key,
    // Internal parameters.
    required ui.Image capturedScreenImage,
  }) : super(
          _LOCATION,
          key: key,
          internalParameters: {
            K_CAPTURED_SCREEN_IMAGE: capturedScreenImage,
          },
        );

  /// Creates a new [ScreenFacadeConfiguration] [from] a
  /// [MyRouteConfiguration] object.
  ScreenFacadeConfiguration.from(
    MyRouteConfiguration from,
  ) : super.fromUri(
          from.uri,
          key: from.key,
          internalParameters: from.internalParameters,
        );

  /// Converts this ScreenFacadeConfiguration object [to] a
  /// [MyRouteConfiguration] object.
  @override
  MyRouteConfiguration to() {
    debugLog(
      "Converting ScreenFacadeConfiguration to MyRouteConfiguration",
    );
    return MyRouteConfiguration.fromUri(
      this.uri,
      key: this.key,
      internalParameters: this.internalParameters,
    );
  }
}

// **************************************************************************

/// Allows child classes to access `screen`, `state` and`configuration`
/// without having to cast them.
abstract class _LogicBroker<T1 extends ScreenFacade, T2 extends _State>
    extends MyScreenLogic<ScreenFacadeConfiguration> {
  late final screen = super.superScreen as T1;
  late final state = super.superState as T2;
  late final configuration = this.state.configuration;
  _LogicBroker(super.superScreen, super.superState);
}
