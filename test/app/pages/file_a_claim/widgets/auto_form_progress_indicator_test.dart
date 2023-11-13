import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/auto_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'auto form progress indicator should have reporter, loss and damage, and drivers and vehicles sections',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: AutoFormProgressIndicator(
            keyReporterSection: GlobalKey(),
            keyLossAndDamageSection: GlobalKey(),
            keyDriversAndVehiclesSection: GlobalKey(),
            reporterSectionStatus: ValueNotifier<ProgressIndicatorStatus>(
              ProgressIndicatorStatus.notStarted,
            ),
            lossAndDamageSectionStatus: ValueNotifier<ProgressIndicatorStatus>(
              ProgressIndicatorStatus.notStarted,
            ),
            driversAndVehiclesSectionStatus:
                ValueNotifier<ProgressIndicatorStatus>(
              ProgressIndicatorStatus.notStarted,
            ),
          ),
        ),
      ),
    );
    expect(
      find.text(AppLocalizationsEn().claimSectionReporter),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimSectionLossAndDamage),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimSectionDriversAndVehicles),
      findsOneWidget,
    );
  });
}
