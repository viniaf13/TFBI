import 'package:permission_handler/permission_handler.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class GoToSettingsDialog extends StatelessWidget {
  const GoToSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TfbBasicDialog(
      confirmActionTitle: context.getLocalizationOf.goToSettingModalConfirm,
      cancelActionTitle: context.getLocalizationOf.goToSettingsModalCancel,
      title: context.getLocalizationOf.goToSettingsModalTitle,
      subtitle: context.getLocalizationOf.goToSettingsModalBody,
      onConfirm: openAppSettings,
      onCancel: () {
        Navigator.of(context).pop(false);
      },
    );
  }
}
