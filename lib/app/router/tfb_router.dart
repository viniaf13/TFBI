import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_unauthenticated_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final authenticatedNavigatorKey = GlobalKey<NavigatorState>();

class TfbRouter extends GoRouter {
  factory TfbRouter({
    required Widget Function(Widget child) unauthenticatedProvidersBuilder,
    required Widget Function(Widget child) authenticatedProvidersBuilder,
    String? initialLocation,
  }) {
    _router ??= TfbRouter._withConfiguration(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialLocation ?? TfbAppRoutes.login.relativePath,
      routes: [
        ShellRoute(
          builder: (context, state, child) => unauthenticatedProvidersBuilder(
            TfbAuthenticationNavigationRedirectListener(child: child),
          ),
          routes: [
            /// unauthenticated routes
            ...tfbUnauthenticatedRoutes,

            /// authenticated routes
            ///
            /// Requires an additional shell route above the
            /// TfbAuthenticatedBottomNavigationRouterShell to allow for
            /// TfbSlideTransitionPages to correctly animate above the bottom
            /// tab bar, while still maintaining access to the blocs, cubits,
            /// clients, repositories, etc that are provided by the
            /// authenticatedProvidersBuilder
            ShellRoute(
              builder: (context, state, child) => authenticatedProvidersBuilder(
                child,
              ),
              navigatorKey: authenticatedNavigatorKey,
              routes: [
                TfbAuthenticatedBottomNavigationRouterShell.instance(),
              ],
            ),
          ],
        ),
      ],
    );

    return _router!;
  }
  TfbRouter._withConfiguration({
    required super.navigatorKey,
    required super.initialLocation,
    required super.routes,
  });
  static TfbRouter? _router;
  static void clear() {
    _router = null;
  }
}
