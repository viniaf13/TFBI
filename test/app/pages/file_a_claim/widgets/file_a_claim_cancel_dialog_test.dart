import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/cancel_claim_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_cancel_dialog.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../mocks/mock_tfb_navigator.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import '../../../analytics/mock_analytics_provider.dart';

void main() {
  late MockTfbNavigator mockNavigator;
  late MockAnalyticsProvider mockAnalyticsProvider;

  setUp(() {
    mockNavigator = MockTfbNavigator();
    mockAnalyticsProvider = MockAnalyticsProvider();
    TfbAnalytics.instance.add(mockAnalyticsProvider);
    TfbAnalytics.instance.init(const TfbAnalyticsConfig());
  });
  testWidgets('File a claim cancel dialog should render with no error',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: CancelAClaimDialog(
            policy: PolicySelection(
              insuredName: 'insured name',
              policyNumber: 'policy number',
              policySymbol: 'policy symbol',
              policyType: PolicyType.txPersonalAuto,
            ),
          ),
        ),
      ),
    );
    expect(
      find.text(AppLocalizationsEn().cancelButtonTitleOnCancelClaimDialog),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().continueButtonTitleOnCancelClaimDialog),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().cancelHeaderOnCancelClaimDialog),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().cancelTitleOnCancelClaimDialog),
      findsOneWidget,
    );
  });
  testWidgets('On click cancel should navigate to Claims Details page',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Scaffold(
          body: CancelAClaimDialog(
            policy: PolicySelection(
              insuredName: 'insured name',
              policyNumber: 'policy number',
              policySymbol: 'policy symbol',
              policyType: PolicyType.txPersonalAuto,
            ),
          ),
        ),
      ),
    );

    await tester.tap(
      find.text(AppLocalizationsEn().cancelButtonTitleOnCancelClaimDialog),
    );
    await tester.pumpAndSettle();

    verify(mockNavigator.goToClaimsDetailsPage).called(1);
  });
  testWidgets(
      'On click cancel should fire a cancel claim event for Auto claims',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Scaffold(
          body: CancelAClaimDialog(
            policy: PolicySelection(
              insuredName: 'insured name',
              policyNumber: 'policy number',
              policySymbol: 'policy symbol',
              policyType: PolicyType.txPersonalAuto,
            ),
          ),
        ),
      ),
    );

    await tester.tap(
      find.text(AppLocalizationsEn().cancelButtonTitleOnCancelClaimDialog),
    );
    await tester.pumpAndSettle();

    final event =
        mockAnalyticsProvider.loggedEvents.whereType<CancelClaimEvent>().first;
    expect(
      event.properties['policy_number'],
      'policy number',
    );
    expect(
      event.properties['policy_type'],
      AppLocalizationsEn().txPersonalAutoPolicyName,
    );
    expect(
      event.properties['screen_name'],
      'Auto claim form',
    );
    expect(
      event.properties['cta'],
      'Yes, cancel',
    );
  });

  testWidgets(
      'On click cancel should fire a cancel claim event for Property claims',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Scaffold(
          body: CancelAClaimDialog(
            policy: PolicySelection(
              insuredName: 'insured name',
              policyNumber: 'policy number',
              policySymbol: 'policy symbol',
              policyType: PolicyType.homeowners,
            ),
          ),
        ),
      ),
    );

    await tester.tap(
      find.text(AppLocalizationsEn().cancelButtonTitleOnCancelClaimDialog),
    );
    await tester.pumpAndSettle();

    final event =
        mockAnalyticsProvider.loggedEvents.whereType<CancelClaimEvent>().first;
    expect(
      event.properties['policy_number'],
      'policy number',
    );
    expect(
      event.properties['policy_type'],
      AppLocalizationsEn().homeownersPolicyName,
    );
    expect(
      event.properties['screen_name'],
      'Property claim form',
    );
    expect(
      event.properties['cta'],
      'Yes, cancel',
    );
  });
}
