import 'package:flutter/material.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class AppUpdateDialog extends StatelessWidget {
  const AppUpdateDialog({
    required this.androidLink,
    required this.iosLink,
    required this.forceUpdate,
    super.key,
  });

  final String androidLink;
  final String iosLink;
  final bool forceUpdate;

  @override
  Widget build(BuildContext context) {
    final titles = context.getLocalizationOf;
    final appStore = Theme.of(context).platform == TargetPlatform.iOS
        ? iosLink
        : androidLink;
    return WillPopScope(
      onWillPop: () async => !forceUpdate,
      child: TfbBasicDialog(
        confirmActionTitle: titles.appUpdateDialogConfirmCTA,
        cancelActionTitle: titles.appUpdateDialogCancelCTA,
        title: titles.appUpdateDialogTitle,
        subtitle: forceUpdate
            ? titles.appUpdateDialogForceSubTitle
            : titles.appUpdateDialogSubTitle,
        onConfirm: () async {
          await context.openUrl(url: appStore);
        },
        onCancel: forceUpdate
            ? null
            : () {
                Navigator.pop(context);
              },
      ),
    );
  }
}
