import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_snackbar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_snackbar_content.dart';

extension SnackBarExtension on BuildContext {
  void showProcessingSnackBar({
    required String text,
    Widget? icon,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      TfbSnackbar(
        showCloseIcon: false,
        duration: duration ??
            const Duration(
              milliseconds: 4000,
            ),
        backgroundColor: LightColors.processingSnackbarBackground,
        content: TfbSnackbarContent(
          icon: icon,
          text: Padding(
            padding: const EdgeInsets.only(right: kSpacingSmall),
            child: Text(
              text,
              style: tfbText.bodyMediumSmall.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showErrorSnackBar({required String text}) {
    ScaffoldMessenger.of(this)
        .showSnackBar(
          TfbSnackbar(
            showCloseIcon: false,
            backgroundColor: LightColors.errorSnackbarBackground,
            duration: const Duration(days: 1),
            content: TfbSnackbarContent(
              iconTapAreaHeight: 44,
              iconTapAreaWidth: 44,
              icon: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  ScaffoldMessenger.of(this).hideCurrentSnackBar();
                },
                child: const Icon(
                  Icons.close_rounded,
                  color: TfbBrandColors.redHighest,
                  size: 24,
                ),
              ),
              text: Padding(
                padding: const EdgeInsets.only(right: kSpacingSmall),
                child: Text(
                  text,
                  style: tfbText.bodyMediumSmall.copyWith(
                    color: TfbBrandColors.redHighest,
                  ),
                ),
              ),
            ),
          ),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(this).clearSnackBars());
  }

  void showSuccessSnackBar({
    required String text,
    required Widget icon,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      TfbSnackbar(
        showCloseIcon: false,
        backgroundColor: LightColors.successSnackbarBackground,
        duration: duration ?? const Duration(milliseconds: 4000),
        content: TfbSnackbarContent(
          icon: icon,
          text: Padding(
            padding: const EdgeInsets.only(right: kSpacingSmall),
            child: Text(
              text,
              style: tfbText.bodyMediumSmall.copyWith(
                color: LightColors.textSuccess,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBiometricsErrorSnackBar({required String text}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: TfbBrandColors.blueHighest,
        duration: const Duration(days: 1),
        backgroundColor: LightColors.processingSnackbarBackground,
        content: TfbSnackbarContent(
          text: Padding(
            padding: const EdgeInsets.only(right: kSpacingSmall),
            child: Text(
              text,
              style: tfbText.bodyMediumSmall.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dismissSnackbar() {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
  }
}
