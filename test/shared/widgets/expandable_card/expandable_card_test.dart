import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
    'ExpandableCard widget should be rendered with children widgets correctly',
    (WidgetTester tester) async {
      const textWidget = Text('Text widget test');
      const labelBottomWidget = Text('Bottom label widget');
      final bottomContent = FilledButton(
        onPressed: () {},
        child: const Text(
          'Bottom content widget',
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ExpandableCard(
              headerContent: textWidget,
              expandableSectionLabel: labelBottomWidget,
              expandableSectionContent: [bottomContent],
            ),
          ),
        ),
      );

      final foundExpandableCard = find.byType(ExpandableCard);
      final foundLabelBottomWidget = find.text('Text widget test');
      final foundBottomContent = find.text('Bottom label widget');

      expect(foundExpandableCard, findsOneWidget);
      expect(foundLabelBottomWidget, findsOneWidget);
      expect(foundBottomContent, findsOneWidget);
    },
  );
}
