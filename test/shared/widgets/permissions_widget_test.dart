import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:txfb_insurance_flutter/shared/widgets/permissions_widget.dart';

import '../../widgets/tfb_widget_tester.dart';

void main() {
  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('flutter.baseflow.com/permissions/methods'),
            (methodCall) async {
      if (methodCall.method == 'requestPermissions') {
        return <int, int>{
          Permission.appTrackingTransparency.value:
              PermissionStatus.granted.index,
        };
      }
      return null;
    });
  });
  group('Permissions widget tests', () {
    testWidgets('App tracking transparency permission granted', (tester) async {
      AppPermission? permissionType;
      PermissionStatus? permissionStatus;
      final requestCompleter = Completer<void>();
      await tester.pumpWidget(
        TfbWidgetTester(
          child: PermissionsWidget(
            AppPermission.appTrackingTransparency,
            onRequestComplete: (type, status) {
              permissionType = type;
              permissionStatus = status;
              requestCompleter.complete();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      await requestCompleter.future;
      expect(permissionType, AppPermission.appTrackingTransparency);
      expect(permissionStatus, PermissionStatus.granted);
    });
  });
}
