import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/environment/environment_provider.dart';
import 'package:plugin_haven/plugin_haven.dart';

class ExampleEnvironment extends Environment {
  ExampleEnvironment({
    required this.name,
  });

  String name;
}

void main() {
  late Widget widgetUnderTest;
  late Widget childWidget;

  setUp(() {
    childWidget = Builder(
      builder: ((context) {
        return MaterialApp(
          home: Scaffold(
            body: Text(
              (context.getEnvironment() as ExampleEnvironment).name,
            ),
          ),
        );
      }),
    );
  });

  testWidgets('Child widget can access properties on environment from context',
      (tester) async {
    widgetUnderTest = EnvironmentProvider(
      defaultEnvironment: ExampleEnvironment(name: "example"),
      child: childWidget,
    );

    await tester.pumpWidget(widgetUnderTest);
    expect(find.text("example"), findsOneWidget);
  });
}
