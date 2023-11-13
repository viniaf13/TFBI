import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:plugin_haven/splash/widgets/change_notifier_splash_gate.dart';

void main() {
  testWidgets(
      'A change notifier splash gate with no notifiers moves immediately to the done state after calling RemoveSplashWaiterEvent',
      (WidgetTester tester) async {
    EnvironmentConfiguration envConfig = EnvironmentConfiguration();
    Widget widgetUnderTest = BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(envConfig.splashConfiguration),
      child: Builder(
        builder: (context) {
          context.read<SplashBloc>().add(RemoveSplashWaiterEvent());
          return ChangeNotifierSplashGate(
            envConfig: envConfig,
            splashCompleteBuilder: (context) =>
                const MaterialApp(home: Scaffold(body: Placeholder())),
          );
        },
      ),
    );

    await tester.pumpWidget(widgetUnderTest);
    await tester.pumpAndSettle();
    expect(find.byType(ChangeNotifierSplashGate), findsOneWidget);
    expect(find.byType(Placeholder), findsOneWidget);
  });

  testWidgets(
    'A change notifier splash gate with one change notifier does not move to the done state after calling RemoveSplashWaiterEvent once if the change notifier does not notify',
    (WidgetTester tester) async {
      ChangeNotifier changeNotifier = ChangeNotifier();

      EnvironmentConfiguration envConfig = EnvironmentConfiguration(
        splashConfiguration: WidgetSplashConfiguration(
          widget: Builder(
            builder: (context) {
              context.read<SplashBloc>().add(RemoveSplashWaiterEvent());
              return const Text('Loading...');
            },
          ),
          waiters: [changeNotifier],
        ),
      );

      Widget widgetUnderTest = BlocProvider<SplashBloc>(
        create: (context) => SplashBloc(envConfig.splashConfiguration),
        child: Builder(
          builder: (context) {
            return ChangeNotifierSplashGate(
              envConfig: envConfig,
              splashCompleteBuilder: (context) =>
                  const MaterialApp(home: Scaffold(body: Placeholder())),
            );
          },
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();
      expect(find.byType(ChangeNotifierSplashGate), findsOneWidget);
      expect(find.byType(Placeholder), findsNothing);
    },
  );

  testWidgets(
    'A change notifier splash gate with one change notifier DOES move to the done state after calling RemoveSplashWaiterEvent once if the change notifier DOES notify',
    (WidgetTester tester) async {
      ChangeNotifier changeNotifier = ChangeNotifier();

      EnvironmentConfiguration envConfig = EnvironmentConfiguration(
        splashConfiguration: WidgetSplashConfiguration(
          widget: Builder(
            builder: (context) {
              changeNotifier.notifyListeners();
              context.read<SplashBloc>().add(RemoveSplashWaiterEvent());
              return const Text("Loading...");
            },
          ),
          waiters: [changeNotifier],
        ),
      );

      Widget widgetUnderTest = BlocProvider<SplashBloc>(
        create: (context) => SplashBloc(envConfig.splashConfiguration),
        child: Builder(
          builder: (context) {
            return ChangeNotifierSplashGate(
              envConfig: envConfig,
              splashCompleteBuilder: (context) =>
                  const MaterialApp(home: Scaffold(body: Placeholder())),
            );
          },
        ),
      );

      await tester.pumpWidget(widgetUnderTest);
      await tester.pumpAndSettle();
      expect(find.byType(ChangeNotifierSplashGate), findsOneWidget);
      expect(find.byType(Placeholder), findsOneWidget);
    },
  );
}
