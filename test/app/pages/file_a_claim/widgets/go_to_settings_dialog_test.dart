import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/go_to_settings_dialog.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late bool openSettingsWasCalled;

  setUp(() {
    openSettingsWasCalled = false;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('flutter.baseflow.com/permissions/methods'),
            (methodCall) async {
      if (methodCall.method == 'openAppSettings') {
        openSettingsWasCalled = true;
        return true;
      }
      return null;
    });
  });

  testWidgets(
      'GoToSettingsDialog, when tap confirm, should call openAppSettings method',
      (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: GoToSettingsDialog(),
      ),
    );
    await tester.pump();
    await tester.tap(find.byType(TfbFilledButton));
    await tester.pumpAndSettle();
    expect(openSettingsWasCalled, isTrue);
  });

  testWidgets(
      'GoToSettingsDialog, when tap cancel, should NOT call openAppSettings method',
      (tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: GoToSettingsDialog(),
      ),
    );
    await tester.pump();
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
    expect(openSettingsWasCalled, isFalse);
  });
}
