import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

/// Reusable brand styled button - width is provided by the child.
class TfbFilledButton extends FilledButton {
  TfbFilledButton({
    required super.onPressed,
    required Widget child,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    super.key,
  }) : super(
          style: FilledButton.styleFrom(
            textStyle: const TextStyle(height: 1),
            backgroundColor: backgroundColor ?? TfbBrandColors.blueLowest,
            foregroundColor: foregroundColor ?? TfbBrandColors.blueHighest,
            disabledForegroundColor:
                disabledForegroundColor ?? TfbBrandColors.grayHigh,
            disabledBackgroundColor:
                disabledBackgroundColor ?? TfbBrandColors.grayLow,
            padding: const EdgeInsets.symmetric(horizontal: kSpacingExtraSmall),
            splashFactory: NoSplash.splashFactory,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kSpacingExtraSmall),
              child: child,
            ),
          ),
        );

  factory TfbFilledButton.secondaryTextButton({
    required VoidCallback? onPressed,
    required String title,
    double? width,
    TextStyle? style,
  }) {
    return TfbFilledButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(
            title,
            style: style?.copyWith(height: 1),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  factory TfbFilledButton.primaryTextButton({
    required String title,
    VoidCallback? onPressed,
    double? width,
    TextStyle? style,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return TfbFilledButton(
      backgroundColor: backgroundColor ?? TfbBrandColors.blueHighest,
      foregroundColor: foregroundColor ?? TfbBrandColors.white,
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(
            title,
            style: style?.copyWith(height: 1),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  factory TfbFilledButton.textOnlyButton({
    required String title,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    double? width,
    TextStyle? style,
  }) {
    return TfbFilledButton(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      onPressed: onPressed,
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: kSpacingMedium),
        child: Center(
          child: Text(
            title,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
