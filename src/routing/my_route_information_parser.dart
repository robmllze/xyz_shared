// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart' show RouteInformation, RouteInformationParser;

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRouteInformationParser extends RouteInformationParser<MyRouteConfiguration> {
  //
  //
  //

  /// Where the app may locate to as soon as possible. This is the location
  /// used to open the app, e.g. "/", "home" or "/home?some_query_parameter=1"
  String _locationRequested = "/";
  String get locationRequested => this._locationRequested;

  /// Where the app will locate to by default, unless [locationRequested] is
  /// one of [locationsToOverrideDefault].
  String? _locationDefault;
  String? get locationDefault => this._locationDefault;

  /// Locations that take precedence over [locationDefault].
  final List<RegExp> locationsToOverrideDefault;

  /// On-location callbacks.
  final Map<RegExp, Future<void> Function()> onLocations;

  //
  //
  //

  /// Parses URIs to [MyRouteConfiguration] or [MyRouteConfiguration] to URIs.
  MyRouteInformationParser({
    this.locationsToOverrideDefault = const [],
    this.onLocations = const {},
    String? locationDefault,
  }) : this._locationDefault = locationDefault;

  //
  //
  //

  /// Parses URIs to MyRouteConfiguration.
  @override
  Future<MyRouteConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    // 1. Get the input location.
    final input = routeInformation.location ?? "/";
    // 2. Save the requested location for later use.
    this._locationRequested = input;
    // 3. Determine the output location based on the input location.
    final output = this._determineOutputLocation(this._locationRequested);
    // 4. Call location callbacks.
    /*await*/ this._handleCallbacks(output);
    debugLog("Parsing URI to route configuration: $output");
    return MyRouteConfiguration.fromString(output) /*.cast()*/;
  }

  //
  //
  //

  // Parses MyRouteConfiguration to URIs (and updates browser).
  @override
  RouteInformation? restoreRouteInformation(
    MyRouteConfiguration configuration,
  ) {
    if (kDeveloperMode) {
      // Enable full URLs to be displayed in browser.
      final location = configuration.uri?.toString();
      debugLog("Parsing route configuration to URI: $location");
      return location != null ? RouteInformation(location: location) : null;
    }
    return null;
  }

  //
  //
  //

  /// Determines the appropriate output location based the input location.
  String _determineOutputLocation(String location) {
    // If there's no default starting location, route to the input location.
    if (locationDefault == null) return location;

    // If the input location matches any bypass locations, route to the
    // input location.
    for (final l in this.locationsToOverrideDefault) {
      final hasMatch = l.hasMatch(location);
      if (hasMatch) {
        // Remove the default starting location so that it won't be routed to.
        this._locationDefault = null;
        return location;
      }
    }

    // If the input location does not match any bypass locations, route to the
    // default starting location and remove it so that it won't be routed to
    // again.
    final temp = this._locationDefault!;
    this._locationDefault = null;
    return temp;
  }

  //
  //
  //

  /// Calls all callbacks registered to execute on entering `location`.
  Future<void> _handleCallbacks(String location) async {
    for (final entry in this.onLocations.entries) {
      final hasMatch = entry.key.hasMatch(location);
      if (hasMatch) await entry.value();
    }
  }
}
