//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

enum HavenRoutes { splash, home, auth }

class HavenRouteConfig {
  const HavenRouteConfig(this.route);
  final dynamic route;
  dynamic get configuration => route;
  bool get authGated => false;
}

class AuthRouteConfig extends HavenRouteConfig {
  const AuthRouteConfig(this.authenticated) : super(HavenRoutes.auth);
  final bool authenticated;
  @override
  dynamic get configuration => authenticated;
}
