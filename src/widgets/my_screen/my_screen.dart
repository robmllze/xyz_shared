// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This code is copyrighted - See LICENCE.txt
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/all.dart';

part '_my_screen_logic.dart';
part '_my_screen_page.dart';
part '_my_screen_state.dart';
part '_my_screen_timer.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@GenerateMakeups(
  names: {"overlay", "clear"},
  parameters: {
    "transitionDuration": "Duration",
    "backgroundColor": "Color",
    "titleColor": "Color",
    "isTranslucent": "bool",
  },
)
abstract class MyScreen extends ConsumerStatefulWidget {
  //
  //
  //

  static final pDialog = Pod<Widget?>(null);

  //
  //
  //

  final MyRouteConfiguration configuration;
  final String title;
  final MakeupScreen makeup;
  final Widget? bottomNavigationBar;

  //
  //
  //

  MyScreen(
    this.configuration, {
    String? title,
    MakeupScreen? makeup,
    this.bottomNavigationBar = const MyBottomNavigationBarDefault(),
  })  : this.title = title ?? "name-app".tr(),
        this.makeup = makeup ?? G.theme.screenDefault(),
        super(key: UriKey(configuration.uri));

  //
  //
  //

  MyScreenPage toPage() {
    return MyScreenPage(
      key: UniqueKey(), // super.key as UriKey
      child: this,
    );
  }

  //
  //
  //

  Future<void> onScreenPushEnter() async {
    // TODO: Implement Firebase Analytics here
    //final screenName = this.configuration.uri?.pathSegments[0];
    await Future.wait([
      //G.fbAnalytics.setCurrentScreen(screenName: screenName),
      () async {
        await G.managerBottomNavigationBar.pValue.set(this.bottomNavigationBar);
      }(),
    ]);

    debugLog("Entering ${this.configuration.uri}");
  }

  //
  //
  //

  Future<void> onScreenPushExit() async {
    debugLog("Exiting ${this.configuration.uri}");
  }

  //
  //
  //

  Future<void> onPostScreenBuild(BuildContext context) async {
    debugLog("Building ${this.configuration.uri}");
    await G.managerBottomNavigationBar.pValue.set(this.bottomNavigationBar);
  }

  //
  //
  //

  Future<void> onScreenPop() async {
    debugLog("Popping ${this.configuration.uri}");
  }

  //
  //
  //

  MyScreenLogic createLogic(MyScreen screen, MyScreenState state);
}
