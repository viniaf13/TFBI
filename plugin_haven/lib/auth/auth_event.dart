//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

part of 'auth_bloc.dart';

/// Parent class for all [AuthEvent].
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => const [];
}

/// Initial [AuthBloc] event. Triggered on [AuthBloc] creation to
/// initialize [AuthRepository]and determine current [AuthState].
class AuthInitEvent extends AuthEvent {}

/// Initiates sign out via [AuthRepository].
class AuthSignOutEvent extends AuthEvent {}

/// Initiates sign in via [AuthRepository].
class AuthSignInEvent extends AuthEvent {
  const AuthSignInEvent({this.type = AuthType.standard, this.properties});

  /// Sign in path for repositories that support multiple methods.
  final AuthType type;

  /// Application specific field to pass attributes through the authentication
  /// flow.
  final dynamic properties;

  @override
  List<Object> get props => [type];
}

/// Internal event triggered on [AuthRepository] change to authenticated.
class _AuthSignedInEvent extends AuthEvent {
  const _AuthSignedInEvent(this.user, {this.properties});

  /// Authenticated user
  final dynamic user;

  /// Attirbutes passed in via [AuthSignInEvent];
  final dynamic properties;

  @override
  List<Object> get props => [user];
}

/// Updates the underlying repository's [HavenUser] user. This can be used to
/// keep local user specific attributes attached to the authenticated user.
class AuthUpdateUserEvent extends AuthEvent {
  const AuthUpdateUserEvent(this.user);

  /// Updated user object
  final HavenUser user;

  @override
  List<Object> get props => [user];
}

/// Internal event triggered by [AuthRepository] change to unauthenticated.
class _AuthSignedOutEvent extends AuthEvent {}

/// Cancel any in progress authentication. Invoke [AuthRepository] cancel
/// and return [AuthState] to [AuthSignedIn] or [AuthSignedOut]. Used to
/// transition out of [AuthProcessing] or [AuthError] states and revert to
/// previous state.
class AuthCancelEvent extends AuthEvent {}

/// Wraps errors from the [AuthRepository] to emit them  via [AuthError] state.
class AuthErrorEvent extends AuthEvent {
  const AuthErrorEvent(this.error);

  /// Error object from [AuthRepository]
  final dynamic error;

  @override
  List<Object> get props => [error];
}

/// Wraps log messages from [AuthRepository] and emits them via updated
/// [AuthProcessing] states for debug or analytics.
class AuthLogEvent extends AuthEvent {
  const AuthLogEvent(this.message);

  /// Pass through [AuthRepository.logMessage]
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Used to wrap navigation changes of a web view based OAuth flow and pass
/// them down to [AuthRepository.receivedResponse] for handling or errors,
/// state tokens, authorization codes, and redirects.
///
/// This can be used to avoid any package dependency if an auth flow needs
/// customizations that a package does not expose or allow.
class AuthFlowEvent extends AuthEvent {
  const AuthFlowEvent(this.response);

  /// Web view navigation request URL
  final String response;

  @override
  List<Object?> get props => [response];
}
