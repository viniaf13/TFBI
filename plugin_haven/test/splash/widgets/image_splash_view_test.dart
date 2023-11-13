import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';

void main() {
  late Widget widgetUnderTest;
  late SplashBloc splashBloc;
  late Widget splashProvider;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    widgetUnderTest = const ImageSplashView(imageAsset: 'assets/images/br.png');

    splashBloc = SplashBloc(
      WidgetSplashConfiguration(widget: const Placeholder()),
    );

    splashProvider = MaterialApp(
      home: Scaffold(
        body: BlocProvider<SplashBloc>(
          create: (context) => splashBloc,
          child: widgetUnderTest,
        ),
      ),
    );
  });

  testWidgets(
      'Image splash view automatically emits a RemoveSplashWaiterEvent to hide splash screen',
      (tester) async {
    await tester.pumpWidget(splashProvider);
    await tester.pumpAndSettle();
    expect(splashBloc.state, isA<DoneSplashState>());
  });

  testWidgets('Image splash view displays an Image.asset widget',
      (tester) async {
    await tester.pumpWidget(splashProvider);
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
  });
}
