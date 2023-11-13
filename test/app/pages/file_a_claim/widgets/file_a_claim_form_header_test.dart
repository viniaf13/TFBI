import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/auto_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_form_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/property_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'File an auto claim form header should render policy number, insured name and auto progress indicator',
      (tester) async {
    const String policyNumber = '1234567890';
    const String insuredName = 'John Doe';
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: FileAClaimFormHeader(
            policyType: PolicyType.txPersonalAuto,
            policyNumber: policyNumber,
            insuredName: insuredName,
            keyLossAndDamageSection: GlobalKey(),
            keyReporterSection: GlobalKey(),
            keyDriversAndVehiclesSection: GlobalKey(),
            reporterSectionStatus: ValueNotifier(
              ProgressIndicatorStatus.notStarted,
            ),
            lossAndDamageSectionStatus: ValueNotifier(
              ProgressIndicatorStatus.notStarted,
            ),
            driversAndVehiclesSectionStatus: ValueNotifier(
              ProgressIndicatorStatus.notStarted,
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(
        AppLocalizationsEn().fileAClaimHeaderPolicyNumber(policyNumber),
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().fileAClaimHeaderInsuredName(insuredName),
      ),
      findsOneWidget,
    );
    expect(
      find.byType(AutoFormProgressIndicator),
      findsOneWidget,
    );
  });

  testWidgets(
      'File a property claim form header should render policy number, insured name and property progress indicator',
      (tester) async {
    const String policyNumber = '1234567890';
    const String insuredName = 'John Doe';
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: FileAClaimFormHeader(
            policyType: PolicyType.homeowners,
            policyNumber: policyNumber,
            insuredName: insuredName,
            keyLossAndDamageSection: GlobalKey(),
            keyReporterSection: GlobalKey(),
            reporterSectionStatus: ValueNotifier(
              ProgressIndicatorStatus.notStarted,
            ),
            lossAndDamageSectionStatus: ValueNotifier(
              ProgressIndicatorStatus.notStarted,
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(
        AppLocalizationsEn().fileAClaimHeaderPolicyNumber(policyNumber),
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().fileAClaimHeaderInsuredName(insuredName),
      ),
      findsOneWidget,
    );
    expect(
      find.byType(PropertyFormProgressIndicator),
      findsOneWidget,
    );
  });
}
