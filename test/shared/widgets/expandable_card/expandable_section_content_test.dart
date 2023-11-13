import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_section_content.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
    'ExpandableContentSection widget should be rendered with correct title and the children should be not visible',
    (WidgetTester tester) async {
      const titleWidget = Text('Text title widget test');
      const contentWidget = Text('Text content widget');

      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: ExpandableSectionContent(
              title: titleWidget,
              children: [contentWidget],
            ),
          ),
        ),
      );

      final foundExpandableContentSection =
          find.byType(ExpandableSectionContent);
      final foundTextChild = find.byType(Text);

      final Text textChild = tester.widget(foundTextChild);

      expect(foundExpandableContentSection, findsOneWidget);
      expect(foundTextChild, findsOneWidget);

      expect(textChild.data, 'Text title widget test');

      expect(find.text('Text content widget'), findsNothing);
    },
  );

  testWidgets(
    'ExpandableContentSection widget should be rendered with correct title and the children should be not visible',
    (WidgetTester tester) async {
      const titleWidget = Text('Text title widget test');
      const contentWidget = Text('Text content widget');

      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: ExpandableSectionContent(
              title: titleWidget,
              children: [contentWidget],
            ),
          ),
        ),
      );

      final foundExpandableContentSection =
          find.byType(ExpandableSectionContent);
      final foundTextChild = find.byType(Text);

      final Text textChild = tester.widget(foundTextChild);

      expect(foundExpandableContentSection, findsOneWidget);
      expect(foundTextChild, findsOneWidget);

      expect(textChild.data, 'Text title widget test');

      expect(find.text('Text content widget'), findsNothing);
    },
  );

  testWidgets(
    'ExpandableContentSection children widgets should be visible when the widget is tapped',
    (WidgetTester tester) async {
      const titleWidget = Text('Text title widget test');
      const contentWidget = Text('Text content widget one');
      const otherContentWidget = Text('Text content widget two');

      await tester.pumpWidget(
        const TfbWidgetTester(
          child: Scaffold(
            body: ExpandableSectionContent(
              title: titleWidget,
              children: [contentWidget, otherContentWidget],
            ),
          ),
        ),
      );

      final foundExpandableContentSection =
          find.byType(ExpandableSectionContent);
      final foundTextChild = find.byType(Text);

      final Text textChild = tester.widget(foundTextChild);

      expect(foundExpandableContentSection, findsOneWidget);
      expect(foundTextChild, findsOneWidget);

      expect(textChild.data, 'Text title widget test');
      expect(find.text('Text content widget one'), findsNothing);
      expect(find.text('Text content widget two'), findsNothing);

      await tester.tap(foundExpandableContentSection);
      await tester.pumpAndSettle();

      expect(find.text('Text content widget one'), findsOneWidget);
      expect(find.text('Text content widget two'), findsOneWidget);
    },
  );
}
