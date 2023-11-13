//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:plugin_haven/router/haven_route_config.dart';

class HavenRouter extends RouterDelegate<HavenRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<HavenRouteConfig> {
  late HavenRouteConfig _configuration = const HavenRouteConfig('/');
  HavenRouteConfig get configuration => _configuration;
  set configuration(HavenRouteConfig value) {
    if (_configuration == value) return;
    _configuration = value;
    notifyListeners();
  }

  // Web
  @override
  HavenRouteConfig get currentConfiguration => configuration;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(HavenRouteConfig configuration) async {
    this.configuration = configuration;
  }

  @override
  Widget build(BuildContext context) {
    // implement build in child
    throw UnimplementedError();
  }
}
