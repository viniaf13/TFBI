import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class TfbBasicDialog extends StatelessWidget {
  const TfbBasicDialog({
    required this.confirmActionTitle,
    required this.cancelActionTitle,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.onCancel,
    super.key,
    this.confirmActionTitleColor,
    this.confirmButtonBackgroundColor,
  });

  final String confirmActionTitle;
  final Color? confirmActionTitleColor;
  final Color? confirmButtonBackgroundColor;

  final String cancelActionTitle;

  final String title;
  final String subtitle;

  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: context.radii.defaultRadius),
      contentPadding: const EdgeInsets.fromLTRB(
        kSpacingMedium,
        kSpacingMedium,
        kSpacingMedium,
        kSpacingMedium,
      ),
      backgroundColor: LightColors.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingSmall),
            child: Text(
              title,
              style: context.tfbText.header3.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          ),
          Text(
            subtitle,
            style: context.tfbText.bodyRegularLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSpacingLarge),
            child: SizedBox(
              width: double.infinity,
              child: TfbFilledButton.primaryTextButton(
                onPressed: onConfirm,
                title: confirmActionTitle,
                backgroundColor: confirmButtonBackgroundColor,
                style: context.tfbText.bodyMediumSmall.copyWith(
                  color: confirmActionTitleColor ?? TfbBrandColors.white,
                ),
              ),
            ),
          ),
          if (onCancel != null)
            Padding(
              padding: const EdgeInsets.only(top: kSpacingSmall),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onCancel,
                  child: Text(
                    cancelActionTitle,
                    style: context.tfbText.bodyMediumSmall.copyWith(
                      color: TfbBrandColors.blueHighest,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
