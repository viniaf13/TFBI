import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class RegisterAccountButton extends StatelessWidget {
  const RegisterAccountButton({
    this.childWidget,
    this.onPressed,
    this.disabled,
    super.key,
  });

  final void Function()? onPressed;
  final Widget? childWidget;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return TfbFilledButton.primaryTextButton(
      onPressed: (disabled ?? false) ? null : onPressed,
      title: context.getLocalizationOf.registerButtonLabel,
    );
  }
}
