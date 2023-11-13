//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:plugin_haven/auth/auth.dart';

/// Interface for Authenticator implementations.
/// Apps provide an implementation of [AuthRepository] to let [AuthBloc] manage
/// standard authentication transitions and states.
abstract class AuthRepository<T> with ChangeNotifier {
  /// [AuthBloc] checks for error condition when notified
  Exception? error;

  /// Signals that authenticition is in progress
  bool get isAuthenticating;

  /// Latest log message
  String? get logMessage;

  /// True when there is an authenticated user
  bool get isSignedIn;

  /// Current authenticated user if one exists
  T? get user;

  /// Initialize. Authentication state should be known after completion.
  /// Typical steps are to retrieve a refresh token if available and exchange
  /// to create a new authenticated state. The resulting ID token is decoded
  /// to get the user.
  Future<void> init();

  /// Begin authentication. Interim updates in auth process (logs, error) and
  /// completion (user is set), are signaled via [ChangeNotifier].
  Future<T?> signIn({AuthType type = AuthType.standard, dynamic credentials});

  /// Sign out. Must always succeed in returning [AuthRepository] to
  /// unauthenticated state.
  Future<dynamic> signOut();

  /// Cancel in progress authentication. Used to close any local resources
  /// set up for auth (e.g. local server) or clear error state.
  Future<void> cancel();

  /// May be used to update user with app or session specific attributes.
  /// Be sure to notify [ChangeNotifier] listeners after update.
  void updateUser(T updatedUser);

  /// [AuthBloc] uses this interface to pass through WebView / UI navigation
  /// events. [AuthRepository] uses to capture auth code, redirects, and state
  /// if needed.
  Future<void> receivedResponse(String response, {dynamic credentials}) async {}
}
