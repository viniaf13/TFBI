import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class UpdatePasswordButton extends StatelessWidget {
  const UpdatePasswordButton({
    required this.isValidated,
    required this.isProcessing,
    this.onPressed,
    super.key,
  });

  final bool isValidated;
  final bool isProcessing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TfbFilledButton.primaryTextButton(
      onPressed: isProcessing || !isValidated ? null : onPressed,
      title: context.getLocalizationOf.resetPassword,
    );
  }
}
