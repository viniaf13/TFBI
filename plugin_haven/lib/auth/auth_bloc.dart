//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/auth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Enumeration of auth flows that have been implemented to this interface.
enum AuthType { standard, sso, passwordless, saml }

/// Provides universal authentication state management for Haven apps.
/// Standardizes operational flow between UI and [AuthRepository] to
/// properly handle auth:
/// - initialization
/// - persistence
/// - sign-in
/// - sign-out
/// - errors
/// - logging
/// Abstracts application from details of authentication logic.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authenticator}) : super(AuthInitState()) {
    on<AuthInitEvent>(_init);
    on<AuthSignOutEvent>(_signedOut);
    on<AuthSignInEvent>(_startSignIn);
    on<AuthUpdateUserEvent>(_updateUser);
    on<AuthCancelEvent>(_cancel);
    on<_AuthSignedInEvent>(_signedin);

    /// Internal handler for [AuthRepository] sign out
    on<_AuthSignedOutEvent>((event, emit) => emit(AuthSignedOut()));

    /// Handler for errors
    on<AuthErrorEvent>((event, emit) => emit(AuthError(event.error)));
    on<AuthFlowEvent>(_receivedResponse);

    /// Handler for log messages
    on<AuthLogEvent>(
      (event, emit) => emit(AuthProcessing(logMessage: event.message)),
    );

    /// Begin initialization
    add(AuthInitEvent());
  }

  /// [authenticator] provides specific provider implementation
  /// (e.g. Okta, Auth0, Azure...)
  final AuthRepository authenticator;

  /// Store to pass properties from origin of auth flow to completion.
  dynamic _authProperties;

  /// Initialize [AuthRepository] and emit initial [AuthState].
  Future<void> _init(AuthInitEvent event, Emitter<AuthState> emit) async {
    emit(const AuthProcessing());
    await authenticator.init();
    if (authenticator.isSignedIn) {
      emit(AuthSignedIn(authenticator.user, properties: _authProperties));
    } else {
      emit(AuthSignedOut());
    }
  }

  /// Handler for [_AuthSignedInEvent]. Emits [AuthSignedIn] in response to
  /// a valid authentication from the [AuthRepository].
  Future<void> _signedin(
    _AuthSignedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSignedIn(event.user, properties: _authProperties));
  }

  /// Called when user triggers a [AuthSignOutEvent].
  Future<void> _signedOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthProcessing());
    await authenticator.signOut();
    emit(AuthSignedOut());
  }

  /// Handler for the [AuthRepository.ChangeNotifier]. This is only active
  /// during the authentication process. Expected changes are:
  /// - Errors
  /// - Log messages
  /// - Signed in
  /// - Signed out
  void _authChanged() {
    // Errors override handling of any other change, so should be cleared
    // after handling (e.g. via cancel).
    if (authenticator.error != null) {
      add(AuthErrorEvent(authenticator.error));
    } else if (authenticator.user != null) {
      add(_AuthSignedInEvent(authenticator.user, properties: _authProperties));
    } else if ((authenticator.isAuthenticating) &&
        (authenticator.logMessage != null)) {
      add(AuthLogEvent(authenticator.logMessage!));
      return;
    } else {
      add(_AuthSignedOutEvent());
    }
  }

  /// Handler for [AuthSignInEvent].
  Future<void> _startSignIn(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthProcessing());
    // Saves auth properties to emit with completion of sign in.
    _authProperties = event.properties;
    authenticator.error = null;
    authenticator.removeListener(_authChanged);
    authenticator.addListener(_authChanged);
    authenticator.signIn(type: event.type, credentials: event.properties);
  }

  /// Handler for [AuthUpdateUserEvent]. [_authChanged] listener will signal
  /// completion with an updated [AuthSignedIn] state.
  Future<void> _updateUser(
    AuthUpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthProcessing());
    try {
      authenticator.updateUser(event.user);
    } catch (error) {
      emit(AuthError(error));
    }
  }

  /// Handler for [AuthCancelEvent]. Used to return to [AuthSignedOut] state
  /// when an authentication process fails in [AuthError].
  Future<void> _cancel(AuthCancelEvent event, Emitter<AuthState> emit) async {
    await authenticator.cancel();
    if (state is! AuthSignedIn) {
      emit(AuthSignedOut());
    }
  }

  /// Handler for [AuthFlowEvent]. Passes auth flow steps from UI to
  /// [AuthRepository].
  Future<void> _receivedResponse(
    AuthFlowEvent event,
    Emitter<AuthState> emit,
  ) async {
    authenticator.receivedResponse(
      event.response,
      credentials: _authProperties,
    );
  }
}
