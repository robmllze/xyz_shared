// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import '/all.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class InternetConnectionChecker {
  //
  //
  //

  static const kPingUrl = "https://httpstat.us/200";
  static const kTimeOutDuration = Duration(seconds: 5);
  static const kDebounceDelay = Duration(seconds: 3);

  //
  //
  //

  final pHasInternet = Pod<bool>(true);

  late final StreamSubscription<ConnectivityResult> _stream;
  late final _debouncer = Debouncer(delay: kDebounceDelay, onWaited: this._check);

  //
  //
  //

  Future<void> _check() async {
    try {
      final response = await http.get(Uri.parse(kPingUrl)).timeout(kTimeOutDuration);
      if (response.statusCode == 200) {
        await this.pHasInternet.set(true);
        return;
      }
    } catch (_) {}
    await this.pHasInternet.set(false);
  }

  //
  //
  //

  InternetConnectionChecker({
    void Function()? onInternetConnectionRestored,
    void Function()? onInternetConnectionLost,
  }) {
    this._stream = Connectivity().onConnectivityChanged.listen((_) => this._debouncer());
    this._check().then((_) {
      this.pHasInternet.callbacks.add((_, final connected) async {
        (connected ? onInternetConnectionRestored : onInternetConnectionLost)?.call();
      });
    });
  }

  //
  //
  //

  void dispose() {
    this._stream.cancel();
    this.pHasInternet.dispose();
  }
}
