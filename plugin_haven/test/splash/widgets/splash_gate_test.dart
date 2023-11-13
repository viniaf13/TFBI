import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven/splash/widgets/splash_gate.dart';
import 'package:plugin_haven/splash/widgets/widget_splash_view.dart';

void main() {
  testWidgets(
      'A splash gate in an ImageSplashState displays an ImageSplashView',
      (tester) async {
    SplashBloc splashBloc = SplashBloc(
      ImageSplashConfiguration(imageAsset: 'assets/images/br.png'),
    );

    Widget splashProvider = MaterialApp(
      home: Scaffold(
        body: BlocProvider<SplashBloc>(
          create: (context) => splashBloc,
          child: SplashGate(
            splashCompleteBuilder: (context) {
              return const Placeholder();
            },
          ),
        ),
      ),
    );

    await tester.pumpWidget(splashProvider);

    expect(find.byType(ImageSplashView), findsOneWidget);
    expect(find.byType(Placeholder), findsNothing);
  });

  testWidgets(
      'A splash gate in a WidgetSplashState displays a WidgetSplashView',
      (tester) async {
    SplashBloc splashBloc = SplashBloc(
      WidgetSplashConfiguration(widget: const Placeholder()),
    );

    Widget splashProvider = MaterialApp(
      home: Scaffold(
        body: BlocProvider<SplashBloc>(
          create: (context) => splashBloc,
          child: SplashGate(
            splashCompleteBuilder: (context) {
              return const Text('Done');
            },
          ),
        ),
      ),
    );

    await tester.pumpWidget(splashProvider);

    expect(find.byType(WidgetSplashView), findsOneWidget);
    expect(find.byType(Text), findsNothing);
  });

  testWidgets('A splash gate in a LottieSplashState displays a LottieView',
      (tester) async {
    SplashBloc splashBloc = SplashBloc(
      LottieSplashConfiguration(
        lottieAsset: 'assets/lottie/br.json',
      ),
    );

    Widget splashProvider = MaterialApp(
      home: Scaffold(
        body: BlocProvider<SplashBloc>(
          create: (context) => splashBloc,
          child: SplashGate(
            splashCompleteBuilder: (context) {
              return const Text('Done');
            },
          ),
        ),
      ),
    );

    await tester.pumpWidget(splashProvider);

    expect(find.byType(LottieView), findsOneWidget);
    expect(find.byType(Text), findsNothing);
  });
}
