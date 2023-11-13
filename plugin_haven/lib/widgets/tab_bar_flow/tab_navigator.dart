//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/material.dart';

///TabNavigator
/// Our nested navigation class
/// navigatorKey: Our key for navigation
/// nestedRoutes: routes ordered by stack structure:
///    [last,
///     first]
class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.nestedRoutes,
  }) : super(key: key);

  final Map<String, WidgetBuilder> nestedRoutes;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute:
          nestedRoutes.entries.last.key, //first in stack (last in list)
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: nestedRoutes[routeSettings.name] ??
              nestedRoutes[nestedRoutes.entries.last.key]!,
        );
      },
    );
  }
}
