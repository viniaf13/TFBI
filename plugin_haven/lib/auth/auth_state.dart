//  Copyright © 2021 Bottle Rocket Studios. All rights reserved.

part of 'auth_bloc.dart';

/// Parent class for all [AuthState]
///
/// [AuthBloc] emits states in response to changes in the underlying auth
/// state and auth processing flow during auth actions.
abstract class AuthState extends Equatable {
  const AuthState();
}

/// Initial [AuthState]. [AuthProcessing] should immediately follow as
/// authentication state is determined. Initialization should resolve into
/// [AuthSignedOut] or [AuthSignedIn].
class AuthInitState extends AuthState {
  @override
  List<Object> get props => const [];
}

/// Non-authenticated state. No current user.
class AuthSignedOut extends AuthState {
  @override
  List<Object> get props => const [];
}

/// Authenticated state.
class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.user, {this.properties});

  /// Authenticated user object
  final HavenUser user;

  /// Pass through of authentication properties provided by [AuthSignInEvent].
  /// Useful when one screen starts authentication, but final authentication
  /// state is resolved on a different screen. Attributes can be used to tailor
  /// sign in and analytics based on initial auth attributes.
  final dynamic properties;

  @override
  List<Object> get props => [user];
}

/// Interim state when authentication is not yet known (initialization) or
/// autentication is in progress. Sequential steps in the auth state can be
/// provided via re-emitting this state with an updated [logMessage].
///
/// Emitted on any triggering event that is passed to [AuthRepository].
/// Subsequent state is emitted on completion of associated [AuthRepository]
/// call or on a [ChangeNotifier] update from the [AuthRepository].
class AuthProcessing extends AuthState {
  const AuthProcessing({this.logMessage});

  final String? logMessage;

  @override
  List<Object> get props => [logMessage ?? ''];
}

/// Emitted on [Exception] in any underlying [AuthRepository] call or in
/// response to an [AuthErrorEvent] added to the [AuthBloc].
class AuthError extends AuthState {
  const AuthError(this.error);
  final Object error;

  @override
  List<Object> get props => [error];
}
