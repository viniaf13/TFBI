//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.

import 'package:plugin_haven/auth/auth_repository.dart';
import 'package:plugin_haven/router/router.dart';

class HavenAuthRouter extends HavenRouter {
  HavenAuthRouter({required this.authenticator});

  final AuthRepository authenticator;
  HavenRouteConfig? authCompletionConfig;

  Future<void> completeAuthPath() async {
    final completionRoute = authCompletionConfig;
    if (completionRoute != null) {
      authCompletionConfig = null;
      return setNewRoutePath(completionRoute);
    }
    return Future.value();
  }

  Future<void> setAuthenticatedRoutePath(
    HavenRouteConfig authConfiguration,
  ) async {
    if (configuration.authGated && authenticator.isSignedIn) {
      return setNewRoutePath(authConfiguration);
    } else {
      authCompletionConfig = authConfiguration;
      return setNewRoutePath(const AuthRouteConfig(false));
    }
  }

  @override
  Future<void> setNewRoutePath(HavenRouteConfig configuration) async {
    if (configuration.authGated && !authenticator.isSignedIn) {
      return setAuthenticatedRoutePath(configuration);
    } else {
      return super.setNewRoutePath(configuration);
    }
  }
}
