import 'package:go_router/go_router.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_authenticated_routes.dart';

class TfbAuthenticatedBottomNavigationRouterShell {
  static StatefulShellRoute instance() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => TfbBottomNavigationBar(
        navigationShell: navigationShell,
      ),
      branches: tfbAuthenticatedRoutes,
    );
  }
}
