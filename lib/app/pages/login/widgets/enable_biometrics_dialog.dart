import 'dart:io';

import 'package:txfb_insurance_flutter/app/analytics/events/sign_in_events.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_request.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class EnableBiometricsDialog extends StatelessWidget {
  const EnableBiometricsDialog({
    required this.loginRequest,
    required this.parentContext,
    super.key,
  });

  final LoginRequest loginRequest;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    TfbAnalytics.instance.track(
      const EnableFaceIdModalView(),
    );

    return TfbBasicDialog(
      title: context.getLocalizationOf.enableBio,
      subtitle: context.getLocalizationOf.enableBioSubHeader,
      confirmActionTitle: context.getLocalizationOf.yes,
      cancelActionTitle: context.getLocalizationOf.notNow,
      onConfirm: () async {
        if (Platform.isIOS) {
          parentContext.handleEnablingIosBiometrics(
            loginRequest,
            shouldSaveUser: true,
          );
        } else {
          parentContext.handleEnablingAndroidBiometrics(
            loginRequest,
            shouldSaveUser: true,
          );
        }
        Navigator.pop(context);
      },
      onCancel: () {
        parentContext.handleEnablingAndroidBiometrics(
          loginRequest,
          shouldSaveUser: false,
        );
        Navigator.pop(context);
      },
    );
  }
}
