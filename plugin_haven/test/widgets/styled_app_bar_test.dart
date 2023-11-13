import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/plugin_haven.dart';

void main() {
  Widget materialApp({required PreferredSizeWidget appBar}) {
    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
      ),
    );
  }

  group('StyledAppBar Widget Tests', () {
    testWidgets('StyledAppBar is AppBar', (tester) async {
      const widget = StyledAppBar(
        title: 'title',
        background: Colors.red,
        key: Key('key'),
      );
      final app = materialApp(appBar: widget);
      await tester.pumpWidget(app);
      final scaffold = tester.widgetList<Scaffold>(find.byType(Scaffold)).last;

      expect(scaffold.appBar, widget);
      expect(find.byType(StyledAppBar), findsOneWidget);
      final container = tester
          .widgetList<Container>(find.byKey(const Key('haven_styled_app_bar')))
          .last;
      expect((container.decoration as BoxDecoration).color, Colors.red);
      expect((container.decoration as BoxDecoration).image != null, false);
    });

    testWidgets('StyledAppBar has image decoration', (tester) async {
      const bgImage = AssetImage('assets/images/br.png');
      const widget = StyledAppBar(
        title: 'title',
        background: bgImage,
        key: Key('key'),
      );
      final app = materialApp(appBar: widget);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      final scaffold = tester.widgetList<Scaffold>(find.byType(Scaffold)).last;
      final container = tester
          .widgetList<Container>(find.byKey(const Key('haven_styled_app_bar')))
          .last;

      expect(scaffold.appBar, widget);
      expect((container.decoration as BoxDecoration).image != null, true);
    });

    testWidgets('StyledAppBar has trailing logo', (tester) async {
      const bgImage = AssetImage('assets/images/br.png');
      const widget = StyledAppBar(
        title: 'title',
        background: Colors.red,
        logo: bgImage,
        key: Key('key'),
      );
      final app = materialApp(appBar: widget);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      final scaffold = tester.widgetList<Scaffold>(find.byType(Scaffold)).last;
      expect(scaffold.appBar, widget);
      expect(
        find.byKey(const Key('haven_styled_app_bar_logo')),
        findsOneWidget,
      );
    });

    testWidgets('StyledAppBar supports tab bar', (tester) async {
      var index = 3;
      final widget = StyledAppBar.withTabs(
        title: 'title',
        background: Colors.red,
        tabs: const [
          Tab(
            text: 'tab 1',
          ),
          Tab(
            text: 'tab 2',
          ),
        ],
        onTabChanged: (value) => index = value,
        key: const Key('key'),
      );
      final app = materialApp(appBar: widget);
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      final scaffold = tester.widgetList<Scaffold>(find.byType(Scaffold)).last;
      expect(scaffold.appBar, widget);
      await tester.tap(find.text('tab 2'));
      await tester.pumpAndSettle();
      expect(index, 1);
    });
  });
}
