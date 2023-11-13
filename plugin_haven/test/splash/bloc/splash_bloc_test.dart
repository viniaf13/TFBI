import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';

void main() {
  late SplashConfiguration initConfig;

  setUp(() {
    initConfig = LottieSplashConfiguration(
      lottieAsset: 'assets/lottie/launch.json',
    );
  });

  /// Write a testBloc to test that the SplashBloc starts in an InitialSplashState
  blocTest<SplashBloc, SplashState>(
    'SplashBloc should move immediately to done state if no splash configuration is provided',
    build: () => SplashBloc(null),
    expect: () => [const DoneSplashState()],
  );

  blocTest<SplashBloc, SplashState>(
    'Splash bloc should move to DisplaySplashState if splash configuration is provided',
    build: () => SplashBloc(initConfig),
    expect: () => [isA<DisplaySplashState>()],
  );

  blocTest<SplashBloc, SplashState>(
    'Splash bloc should move to DoneSplashState if splash configuration is provided, splash is complete, and no listeners are registered',
    build: () => SplashBloc(initConfig),
    act: (bloc) => bloc.add(RemoveSplashWaiterEvent()),
    expect: () => [isA<DisplaySplashState>(), const DoneSplashState()],
  );

  blocTest<SplashBloc, SplashState>(
    'Splash bloc should not move to DoneSplashState if splash configuration is provided, splash is complete, but listeners have not all notified',
    build: () => SplashBloc(initConfig),
    act: (bloc) {
      bloc.add(AddSplashWaiterEvent());
      bloc.add(RemoveSplashWaiterEvent());
    },
    expect: () => [
      isA<DisplaySplashState>(),
    ],
  );

  blocTest<SplashBloc, SplashState>(
    'Splash bloc should move to DoneSplashState after splash is complete and all listeners have notified',
    build: () => SplashBloc(initConfig),
    act: (bloc) {
      bloc.add(AddSplashWaiterEvent());
      bloc.add(RemoveSplashWaiterEvent());
      bloc.add(RemoveSplashWaiterEvent());
    },
    expect: () => [
      isA<DisplaySplashState>(),
      const DoneSplashState(),
    ],
  );

  test('Splash bloc event equality', () {
    // Two events with the same configuration should be equal
    var splashConfiguration =
        WidgetSplashConfiguration(widget: const Placeholder());
    expect(
      DisplaySplashEvent(
            splashConfiguration,
          ) ==
          DisplaySplashEvent(
            splashConfiguration,
          ),
      true,
    );

    // Two events with different configurations should not be equal
    expect(
      DisplaySplashEvent(
            splashConfiguration,
          ) ==
          DisplaySplashEvent(
            WidgetSplashConfiguration(widget: const Placeholder()),
          ),
      false,
    );

    // Two events instances of the same event should be equal
    expect(
      RemoveSplashWaiterEvent() == RemoveSplashWaiterEvent(),
      true,
    );
  });
}
