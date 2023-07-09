// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// This file is closed-sourced. See LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'dart:ui' as ui show Image;

import '/all.dart';

part '_no_animation_material_page_route.dart';
part '_no_animation_transition_delegate.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef _HistoryMap = LinkedHashMap<DateTime, MyRouteConfiguration?>;

/// A service that handles the routing.
class MyRouterDelegate extends RouterDelegate<MyRouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouteConfiguration> {
  //
  //
  //

  static const REC = Rec("MyRouterDelegate");

  //
  //
  //

  final _facadeKey = GlobalKey();

  Future<ui.Image> captureScreenImage() async {
    final boundary = this._facadeKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    return image;
  }

  Future<void> replaceWithFacade() async {
    await G.router.replace(
      ScreenFacadeConfiguration(
        capturedScreenImage: await captureScreenImage(),
      ),
    );
  }

  Future<void> pushFacade() async {
    await G.router.push(
      ScreenFacadeConfiguration(
        capturedScreenImage: await captureScreenImage(),
      ),
    );
  }

  //
  //
  //

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // ignore: prefer_collection_literals
  final _history = _HistoryMap();
  _HistoryMap get history => _HistoryMap.of(this._history);

  final _stack = <MyScreenPage>[];

  dynamic _transitionDelegate = const NoAnimationTransitionDelegate();

  MyRouteConfiguration? _currentConfiguration;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    if (!kDeveloperMode) {
      // Disable browser "<-" and "->" buttons
      hDisablePop();
    }

    // Refresh the current route immediately after the theme changes.
    G.pTheme.addListener((_) {});
  }

  //
  //
  //

  MyRouteConfiguration? _previousConfigurations(int index) {
    final values = this.history.values.toList();
    try {
      return values[values.length - 1 - index];
    } catch (_) {
      return null;
    }
  }

  //
  //
  //

  @override
  MyRouteConfiguration? get currentConfiguration {
    return this._currentConfiguration;
  }

  //
  //
  //

  String? get currentLocation {
    return this._previousConfigurations(0)?.uri.toString();
  }

  //
  //
  //

  T? previousConfiguration<T extends MyRouteConfiguration>() {
    return this._previousConfigurations(1) as T?;
  }

  //
  //
  //

  String? get previousLocation {
    return this.previousConfiguration()?.uri.toString();
  }

  //
  //
  //

  @override
  void notifyListeners() {
    this._currentConfiguration =
        this._stack.isNotEmpty ? this._stack.last.screen.configuration : null;
    super.notifyListeners();
  }

  //
  //
  //

  @override
  Future<bool> popRoute() async {
    if (await this._pop()) {
      // Uncomment to refresh URI displayed in browser.
      //hPushState(currentLocation);
      this.notifyListeners();
      return true;
    }
    return false;
  }

  //
  //
  //

  Future<void> push<T extends MyRouteConfiguration>(T configuration) async {
    final page = (await MyScreenBuilder.instance.build(configuration))?.toPage();
    if (page != null) {
      this._stack.removeWhere((final l) => l.key == page.key);
      this._stack.add(page);
      this.notifyListeners();
    }
  }

  //
  //
  //

  Future<bool> _pop() async {
    await this.currentPage?.screen.onScreenPop();
    if (this._stack.isNotEmpty) {
      this._stack.removeLast();
      return this._stack.isNotEmpty;
    } else {
      return false;
    }
  }

  //
  //
  //

  Future<void> _popSafe() async {
    if (!await this._pop()) {
      await this.push(MyRouteConfiguration("/"));
    }
  }

  //
  //
  //

  Future<void> _clear() async {
    for (final l in this._stack) {
      await l.screen.onScreenPop();
    }
    this._stack.clear();
  }

  //
  //
  //

  // Do not change
  Future<void> replace(MyRouteConfiguration configuration) async {
    await this.pop();
    await this.push(configuration);
  }

  //
  //
  //

  Future<void> set(MyRouteConfiguration configuration) async {
    await this._clear();
    await this.push(configuration);
  }

  //
  //
  //

  Future<void> _prev(Future<void> Function(MyRouteConfiguration) action) async {
    final previousConfiguration = this.previousConfiguration();
    if (previousConfiguration != null) {
      await action(previousConfiguration);
    }
  }

  //
  //
  //

  @override
  Future<void> setNewRoutePath(MyRouteConfiguration configuration) async {
    if (!kDeveloperMode) {
      // Disable browser "<-" and "->" buttons.
      hPushState("/");
    }
    await this.push(configuration);
  }

  //
  //
  //

  @visibleForTesting
  Future<void> pushLocation(
    String location, {
    Map<String, String>? queryArguments,
  }) async {
    await this.push<MyRouteConfiguration>(
      MyRouteConfiguration(
        location,
        queryParameters: queryArguments,
      ),
    );
  }

  //
  //
  //

  Future<void> pushPrev() async {
    await this._prev(this.push);
  }

  //
  //
  //

  @visibleForTesting
  Future<void> replaceLocation(
    String location, {
    Map<String, String>? queryArguments,
  }) async {
    await this.replace(
      MyRouteConfiguration(
        location,
        queryParameters: queryArguments,
      ),
    );
  }

  //
  //
  //

  Future<void> replacePrev() async {
    await this._prev(this.replace);
  }

  //
  //
  //

  @visibleForTesting
  Future<void> setLocation(
    String location, {
    Map<String, String>? queryArguments,
  }) async {
    await this.set(
      MyRouteConfiguration(
        location,
        queryParameters: queryArguments,
      ),
    );
  }

  //
  //
  //

  Future<void> setPrev() async {
    await this._prev(this.set);
  }

  //
  //
  //

  Future<void> reset() async {
    await this.setLocation("/");
  }

  //
  //
  //

  Future<bool> pop() async {
    if (await this._pop()) {
      // Uncomment to refresh URI displayed in browser.
      //hPushState(currentLocation);
      this.notifyListeners();
      return true;
    }
    return false;
  }

  //
  //
  //

  Future<void> popSafe() async {
    await this._popSafe();
    // Uncomment to refresh URI displayed in browser.
    //hPushState(currentLocation);
    this.notifyListeners();
  }

  //
  //
  //

  Future<void> popSafeUntil(String location) async {
    while (location != this.currentLocation) {
      if (!await this._pop()) {
        await this.push(MyRouteConfiguration("/"));
        break;
      }
    }
  }

  //
  //
  //

  void andAnimate() {
    this._transitionDelegate = const DefaultTransitionDelegate();
  }

  //
  //
  //

  MyScreenPage? get currentPage => this._stack.isNotEmpty ? this._stack.last : null;

  //
  //
  //

  Widget _navigator(MyScreenPage currentPage) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Navigator(
          key: this.navigatorKey,
          transitionDelegate: () {
            final temp = this._transitionDelegate;
            this._transitionDelegate = const NoAnimationTransitionDelegate();
            return temp;
          }(),
          pages: [
            MyTransparentPage(),
            if (this._stack.length == 1) ...[
              ...this._stack,
            ] else if (this._stack.length > 1) ...[
              ...this._stack.sublist(0, this._stack.length - 1),
              this._stack.last,
            ]
          ],
          onPopPage: (final route, final result) {
            REC("_navigator").debugLogAlert("Called: onPopPage");
            final didPop = route.didPop(result);
            this.notifyListeners();
            return didPop;
          },
        ),
      ],
    );
  }

  //
  //
  //

  @override
  Widget build(final context) {
    final page = this.currentPage ?? ScreenEmpty(ScreenEmptyConfiguration()).toPage();
    final screen = page.screen;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screen.onPostScreenBuild(context);
    });
    this._history[DateTime.now()] = screen.configuration;
    final title = screen.configuration.arguments<String>("title");
    return Title(
      title: title ?? screen.title,
      color: screen.makeup.titleColor,
      child: this._navigator(page),
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyFacadeRepaintBoundary extends StatelessWidget {
  final MyRouterDelegate router;
  final Widget? child;
  const MyFacadeRepaintBoundary({
    super.key,
    required this.router,
    this.child,
  });

  @override
  Widget build(_) {
    return RepaintBoundary(
      key: this.router._facadeKey,
      child: this.child,
    );
  }
}
