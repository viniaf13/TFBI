import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/homeowners_property_detail/homeowners_policy_detail_property.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_section_content.dart';

import '../../../../../widgets/tfb_widget_tester.dart';
import '../../../../../mocks/mock_policy_lookup_client.dart';

void main() {
  late HomeownerPolicyDetail mockDetails;

  setUp(
    () {
      final mockPolicyDetails = MockPolicy.createHomeownerPolicyDetail();

      mockDetails = HomeownerPolicyDetail(
        mockPolicyDetails.propertyLocation,
        mockPolicyDetails.propertyConstruction,
        mockPolicyDetails.policyForm,
        mockPolicyDetails.sections,
        mockPolicyDetails.insuredAddress,
        policyBilling: mockPolicyDetails.policyBilling,
        policyType: mockPolicyDetails.policyType,
        policySubType: mockPolicyDetails.policySubType,
        effectiveDate: mockPolicyDetails.effectiveDate,
        expirationDate: mockPolicyDetails.expirationDate,
        policyDescription: mockPolicyDetails.policyDescription,
        policyNumber: mockPolicyDetails.policyNumber,
      );
    },
  );

  testWidgets(
    'PolicyDetailProperty widget should render title, address and expandable card correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: HomeownersPolicyDetailProperty(details: mockDetails),
          ),
        ),
      );

      final homeownerPolicyDetailWidget =
          find.byType(HomeownersPolicyDetailProperty);

      expect(homeownerPolicyDetailWidget, findsOneWidget);
      expect(find.text('Property'), findsOneWidget);

      final expandableCardWidget = find.byType(ExpandableCard);
      expect(expandableCardWidget, findsOneWidget);
      expect(
        find.text('View coverage information'),
        findsOneWidget,
      );

      final addressWidget = find.byType(AddressWidget);
      expect(addressWidget, findsOneWidget);
      expect(
        find.text(mockDetails.fullAddress!.address1.toTitleCase()),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PolicyDetailProperty widget should render coverage information correctly when expandable card is opened',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: SingleChildScrollView(
              child: HomeownersPolicyDetailProperty(details: mockDetails),
            ),
          ),
        ),
      );

      final expandableSectionContentWidget =
          find.byType(ExpandableSectionContent);

      await tester.tap(expandableSectionContentWidget);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('Liability'), findsOneWidget);
      expect(find.text(mockDetails.sections[0].name), findsOneWidget);
      expect(find.text('Discounts'), findsOneWidget);
      expect(find.text('Mortgagees'), findsOneWidget);
    },
  );
}
