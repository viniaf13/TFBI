import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/how_claims_work_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('How claims work section should render a card with timeline',
      (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: HowClaimsWorkSection(),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().howClaimsWork),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineFileTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineFileDescription),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineShareDetailsTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineShareDetailsDescription),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineGetAnEstimateTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineGetAnEstimateDescription),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineResolveTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().claimsTimeLineResolveDescription),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).shape == BoxShape.circle,
      ),
      findsNWidgets(4),
    );
  });
}
