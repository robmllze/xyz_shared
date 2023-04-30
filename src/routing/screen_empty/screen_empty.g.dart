// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_empty.dart';

// **************************************************************************
// ScreenAccessGenerator
// **************************************************************************

// ignore_for_file: dead_code
// ignore_for_file: unused_element

// **************************************************************************

const _L = "screens.ScreenEmpty";
const _SEGMENT = "empty";
const _LOCATION = "/$_SEGMENT";
const _NAME_SCREEN_CLASS = "ScreenEmpty";

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

const LOCATION_NOT_REDIRECTABLE_EMPTY = [_LOCATION];
const LOCATION_ACCESSIBLE_EMPTY = [_LOCATION];
const LOCATION_ACCESSIBLE_ONLY_IF_SIGNED_IN_AND_VERIFIED_EMPTY = [];
const LOCATION_ACCESSIBLE_ONLY_IF_SIGNED_IN_EMPTY = [];
const LOCATION_ACCESSIBLE_ONLY_IF_SIGNED_OUT_EMPTY = [];

final castScreenEmptyConfiguration = Map<Type,
    MyRouteConfiguration Function(MyRouteConfiguration)>.unmodifiable({
  ScreenEmptyConfiguration: (MyRouteConfiguration a) =>
      ScreenEmptyConfiguration.from(a)
});

MyScreen? makerScreenEmpty(
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
  if (configuration is ScreenEmptyConfiguration ||
      RegExp(
        r"^(" + _LOCATION + r")([?/].*)?$",
      ).hasMatch(
        Uri.decodeComponent(
          configuration.uri.toString(),
        ),
      )) {
    return ScreenEmpty(configuration);
  }
  return null;
}
// **************************************************************************

class ScreenEmptyConfiguration extends MyRouteConfiguration {
  //
  //
  //

  // Some information.

  static const LOCATION = _LOCATION;
  static const L = _L;
  static const NAME_SCREEN_CLASS = _NAME_SCREEN_CLASS;

  /// Creates a new configuration object for [ScreenEmpty]
  /// that can be passed to [G.router] to route to the screen with the applied
  /// configuration.
  ///
  /// Use a unique [key] to allow [G.router] to push multiple instances of
  /// [ScreenEmpty] with different configurations.
  ScreenEmptyConfiguration({
    String? key,
  }) : super(
          _LOCATION,
          key: key,
        );

  /// Creates a new [ScreenEmptyConfiguration] [from] a
  /// [MyRouteConfiguration] object.
  ScreenEmptyConfiguration.from(
    MyRouteConfiguration from,
  ) : super.fromUri(
          from.uri,
          key: from.key,
          internalParameters: from.internalParameters,
        );

  /// Converts this ScreenEmptyConfiguration object [to] a
  /// [MyRouteConfiguration] object.
  @override
  MyRouteConfiguration to() {
    debugLog(
      "Converting ScreenEmptyConfiguration to MyRouteConfiguration",
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
abstract class _LogicBroker<T1 extends ScreenEmpty, T2 extends _State>
    extends MyScreenLogic<ScreenEmptyConfiguration> {
  late final screen = super.superScreen as T1;
  late final state = super.superState as T2;
  late final configuration = this.state.configuration;
  _LogicBroker(super.superScreen, super.superState);
}
