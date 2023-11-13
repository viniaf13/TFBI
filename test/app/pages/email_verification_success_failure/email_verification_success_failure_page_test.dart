import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification_success_failure/email_verification_success_failure_page.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets(
      'When passing an error to the email verification success failure page, the error should be displayed',
      (tester) async {
    const errorMessage = 'CUSTOM ERROR MESSAGE';

    await tester.pumpWidget(
      TfbWidgetTester(
        child: EmailVerificationSuccessFailurePage(
          error: TfbRequestError(message: errorMessage),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().somethingWentWrongTitle),
      findsOneWidget,
    );
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets(
      'When no error is passed to the email verification success failure page, the success copy should be visible',
      (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: EmailVerificationSuccessFailurePage(),
      ),
    );

    expect(find.text(AppLocalizationsEn().successTitle), findsOneWidget);
    expect(
      find.text(AppLocalizationsEn().accountCreatedMessage),
      findsOneWidget,
    );
  });
}
