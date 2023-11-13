import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_update_password_success/forgot_update_password_success_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../mocks/mock_tfb_navigator.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Forgot password update success page shows success icon and copy',
      (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(child: ForgotUpdatePasswordSuccessPage()),
    );

    expect(find.text(AppLocalizationsEn().successTitle), findsOneWidget);
    expect(
      find.text(AppLocalizationsEn().passwordUpdatedSubtitle),
      findsOneWidget,
    );
    expect(
      find.image(AssetImage(TfbAssetStrings.successCheck)),
      findsOneWidget,
    );
  });

  testWidgets(
      'Tapping on the "return to login" button calls the navigator return to login method',
      (tester) async {
    final TfbNavigator mockNavigator = MockTfbNavigator();

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: const ForgotUpdatePasswordSuccessPage(),
      ),
    );

    await tester.tap(find.byType(TfbFilledButton));

    verify(mockNavigator.goToLoginPage).called(1);
  });
}
