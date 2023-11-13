import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return TfbBasicDialog(
      confirmActionTitle: context.getLocalizationOf.confirmLogoutButtonTitle,
      cancelActionTitle: context.getLocalizationOf.cancelButtonTitle,
      title: context.getLocalizationOf.logoutModalTitle,
      subtitle: context.getLocalizationOf.logoutModalSubtitle,
      onConfirm: () {
        Navigator.pop(context);
        context.navigator.goToLoginPage(isLoggingOut: true);
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }
}
