import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    required this.onPress,
    required this.disabled,
    super.key,
  });

  final void Function() onPress;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return TfbFilledButton.primaryTextButton(
      onPressed: disabled ? null : onPress,
      title: context.getLocalizationOf.forgotPasswordSubmitTitle,
    );
  }
}
