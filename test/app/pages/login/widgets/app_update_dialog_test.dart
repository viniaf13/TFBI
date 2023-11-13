import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/app_update_dialog.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  group('AppUpdateDialog', () {
    testWidgets('displays the correct text and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const TfbWidgetTester(
          child: AppUpdateDialog(
            androidLink: 'http://play.google.com/store/mockUrl',
            iosLink: 'http://apps.apple.com/mockUrl',
            forceUpdate: false,
          ),
        ),
      );

      final s = AppLocalizationsEn();
      expect(find.text(s.appUpdateDialogTitle), findsOneWidget);
      expect(find.text(s.appUpdateDialogSubTitle), findsOneWidget);
      expect(find.text(s.appUpdateDialogConfirmCTA), findsOneWidget);
      expect(find.text(s.appUpdateDialogCancelCTA), findsOneWidget);
    });

    testWidgets('displays the correct text and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const TfbWidgetTester(
          child: AppUpdateDialog(
            androidLink: 'http://play.google.com/store/mockUrl',
            iosLink: 'http://apps.apple.com/mockUrl',
            forceUpdate: true,
          ),
        ),
      );

      final s = AppLocalizationsEn();
      expect(find.text(s.appUpdateDialogTitle), findsOneWidget);
      expect(find.text(s.appUpdateDialogForceSubTitle), findsOneWidget);
      expect(find.text(s.appUpdateDialogConfirmCTA), findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
    });
  });
}
