import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';

abstract class NavigatorRouteArgs {
  NavigatorRouteArgs({
    required this.route,
    this.extra,
  });

  final TfbAppRoutes route;
  final Object? extra;
}

class NavigatorRouteWithoutExtra extends NavigatorRouteArgs {
  NavigatorRouteWithoutExtra({required super.route});

  @override
  String toString() {
    return 'NavigatorRouteWithoutExtra: $route';
  }
}

class NavigatorRouteWithExtra extends NavigatorRouteArgs {
  NavigatorRouteWithExtra({required super.route, required super.extra});

  @override
  String toString() {
    return 'NavigatorRouteWithoutExtra: $route';
  }
}
