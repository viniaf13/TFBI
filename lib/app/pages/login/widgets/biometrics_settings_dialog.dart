import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class BiometricsSettingsDialog extends StatelessWidget {
  const BiometricsSettingsDialog({required this.loginRequest, super.key});

  final LoginRequest loginRequest;

  @override
  Widget build(BuildContext context) {
    return TfbBasicDialog(
      title: context.getLocalizationOf.enableBioFromSettings,
      subtitle: context.getLocalizationOf.enableBioFromSettingsSubHeader,
      confirmActionTitle: context.getLocalizationOf.goToSettings,
      cancelActionTitle: context.getLocalizationOf.notNow,
      onConfirm: AppSettings.openAppSettings,
      onCancel: () {
        BlocProvider.of<AuthBloc>(context).add(
          AuthSignInEvent(properties: loginRequest),
        );
        Navigator.pop(context);
      },
    );
  }
}
