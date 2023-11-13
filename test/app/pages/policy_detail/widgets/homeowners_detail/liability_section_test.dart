import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/homeowners_property_detail/liability_section.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<HomeownerSection> mockSections;

  setUp(() {
    final mockPolicyDetails = MockPolicy.createHomeownerPolicyDetail();

    mockSections = mockPolicyDetails.sections;
  });

  testWidgets(
    'LiabilitySection widget should render title and liabilities list correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: LiabilitySection(sections: mockSections),
          ),
        ),
      );

      final liabilitySectionWidget = find.byType(LiabilitySection);

      expect(liabilitySectionWidget, findsOneWidget);
      expect(find.text('Liability'), findsOneWidget);

      for (final section in mockSections) {
        if (section.coverages.isEmpty && section.deductibles.isEmpty) {
          continue;
        }

        expect(find.text(section.name), findsOneWidget);

        expect(
          find.text(
            '${section.coverages[0].group}. ${section.coverages[0].name}',
          ),
          findsOneWidget,
        );
        expect(
          find.text(section.coverages[0].limit.formatCurrency()),
          findsWidgets,
        );

        expect(
          find.text(
            section.deductibles[0].name,
          ),
          findsOneWidget,
        );
        expect(
          find.text(section.deductibles[0].amount.formatCurrency()),
          findsWidgets,
        );
      }
    },
  );
}
