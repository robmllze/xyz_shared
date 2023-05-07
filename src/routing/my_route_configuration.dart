// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import '/all.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRouteConfiguration {
  //
  //
  //

  late final String? key;
  late final Uri? uri;
  late final Map<dynamic, dynamic>? internalParameters;

  //
  //
  //

  MyRouteConfiguration.fromUri(
    this.uri, {
    String? key,
    this.internalParameters,
  }) {
    final uri = this.uri;
    this.key = key ?? uri?.toString();
  }

  //
  //
  //

  factory MyRouteConfiguration.fromString(
    String uri, {
    String? key,
    Map<dynamic, dynamic> internalParameters = const {},
  }) {
    return MyRouteConfiguration.fromUri(
      Uri.tryParse(uri) ?? Uri.tryParse("/"),
      key: key,
      internalParameters: internalParameters.nullIfEmpty(),
    );
  }

  //
  //
  //

  MyRouteConfiguration(
    String uri, {
    String? key,
    List<String>? pathSegments,
    Map<String, String>? queryParameters,
    this.internalParameters,
  }) {
    this.uri = Uri.tryParse(uri)?.replace(
      pathSegments: pathSegments?.nullIfEmpty(),
      queryParameters: queryParameters?.nullIfEmpty(),
    );
    this.key = key ?? this.uri?.toString();
  }

  //
  //
  //

  @override
  int get hashCode => this.key?.toString().hashCode ?? super.hashCode;

  //
  //
  //

  @override
  bool operator ==(Object other) => this.hashCode == other.hashCode;

  //
  //
  //

  T? arguments<T>(dynamic key) {
    return let<T>(
      this.internalParameters?[key] ??
          (key is int
              ? this.uri?.pathSegments.tryElementAt(1)
              : (key is String ? this.uri?.queryParameters[key] : null)),
    );
  }

  //
  //
  //

  MyRouteConfiguration to() => this;
}
