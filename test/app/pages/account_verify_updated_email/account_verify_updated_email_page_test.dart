import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/account_verify_updated_email/account_verify_updated_email_page.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../mocks/mock_context_provider.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Account verify updated email page shows all the right elements',
      (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(child: AccountVerifyUpdatedEmailPage()),
    );

    final localizations = MockBuildContext().getLocalizationOf;
    expect(
      find.text(localizations.accountUpdateEmailVerifyTitle),
      findsOneWidget,
    );
    expect(
      find.text(localizations.updateEmailDidntReceive),
      findsOneWidget,
    );
    expect(
      find.text(localizations.accountUpdateEmailSubtitle),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Image && widget.image is AssetImage,
      ),
      findsOneWidget,
    );
  });
}
