import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/claims_assistance.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Claims Assistance should have a title',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: ClaimsAssistance(),
      ),
    );
    await tester.pumpAndSettle();
    final Finder claimsHeader = find.widgetWithText(
      ClaimsAssistance,
      AppLocalizationsEn().claimsAssistanceTitle,
      skipOffstage: false,
    );

    expect(claimsHeader, findsOneWidget);
  });
}
