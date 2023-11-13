import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/claims_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/property_form_progress_indicator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('property form progress indicator ...', (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: PropertyFormProgressIndicator(
            keyReporterSection: GlobalKey(),
            keyLossAndDamageSection: GlobalKey(),
            reporterSectionStatus: ValueNotifier<ProgressIndicatorStatus>(
              ProgressIndicatorStatus.notStarted,
            ),
            lossAndDamageSectionStatus: ValueNotifier<ProgressIndicatorStatus>(
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
  });
}
