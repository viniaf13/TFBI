//  Copyright © 2020 Bottle Rocket Studios. All rights reserved.

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/splash/bloc/splash_event.dart';
import 'package:plugin_haven/splash/bloc/splash_state.dart';
import 'package:plugin_haven/splash/splash_configuration.dart';

/// @author - Liam McMains
///
/// [SplashBloc] is responsible for managing the splash screen state while the app
/// is initializing in the background.
///
/// Other widgets can register themselves as "waiters" with the splash bloc by
/// adding an [AddSplashWaiterEvent] to the bloc. Registering as a waiter will
/// force the splash screen to remain visible until the waiter has notified the
/// bloc that it has completed initialization via the [RemoveSplashWaiterEvent].
///
/// Once all waiters have notified the bloc that they are complete, the splash
/// screen will be hidden.
///
/// By default, [SplashBloc] does wait for at least one [RemoveSplashWaiterEvent]
/// before hiding the splash screen. If you are using Haven to manage your splash
/// screen then this is called automatically, but if you are using the bloc
/// directly you will need to call [RemoveSplashWaiterEvent] at least once.
///
/// The splash screen can also be forced to hide by adding a [ForceHideSplashEvent]
/// to the bloc.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    SplashConfiguration? splashConfiguration,
  ) : super(const InitialSplashState()) {
    on<DisplaySplashEvent>(_displaySplash);
    on<RemoveSplashWaiterEvent>(_removeSplashWaiter);
    on<AddSplashWaiterEvent>(_addSplashWaiter);
    on<ForceHideSplashEvent>(_forceHideSplash);

    if (splashConfiguration != null) {
      add(DisplaySplashEvent(splashConfiguration));
    } else if (state is InitialSplashState) {
      add(ForceHideSplashEvent());
    }
  }

  /// STATE ///
  /// The number of added waiters that have requested that the splash bloc stay
  /// in the DisplaySplashState until they notify the bloc that they are complete.
  int _registeredWaitersCount = 1;

  /// Returns true if all added waters have notified the bloc that they are complete.
  get _splashBlocComplete => _registeredWaitersCount <= 0;

  /// EVENTS ///
  /// Initialize the splash screen with the provided configuration in the
  /// [DisplaySplashEvent].[splashConfiguration]
  Future<void> _displaySplash(
    DisplaySplashEvent event,
    Emitter<SplashState?> emit,
  ) async {
    emit(DisplaySplashState.fromSplashConfiguration(event.splashConfiguration));
  }

  /// Register that something needs the splash bloc to wait for it to complete
  /// first before hiding the splash screen.
  Future<void> _addSplashWaiter(
    AddSplashWaiterEvent event,
    Emitter<SplashState> emit,
  ) async {
    _registeredWaitersCount += 1;
  }

  /// Register that something has completed and check if the splash bloc can move
  /// to the [DoneSplashState].
  Future<void> _removeSplashWaiter(
    RemoveSplashWaiterEvent event,
    Emitter<SplashState> emit,
  ) async {
    _registeredWaitersCount -= 1;
    if (_splashBlocComplete) {
      add(ForceHideSplashEvent());
    }
  }

  /// Force the splash screen to hide immediately, regardless of the number of
  /// registered waiters.
  Future<void> _forceHideSplash(
    ForceHideSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(const DoneSplashState());
  }
}
