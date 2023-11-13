import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';

class SubmitClaimButton extends StatelessWidget {
  const SubmitClaimButton({
    required this.listanableList,
    required this.onPressed,
    super.key,
  });
  final kheightButton = 98.0;
  final List<ValueNotifier<bool>> listanableList;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kheightButton,
      width: double.maxFinite,
      color: TfbBrandColors.grayLowest,
      padding: const EdgeInsets.only(
        top: kSpacingMedium,
        bottom: kSpacingExtraLarge,
        left: kSpacingMedium,
        right: kSpacingMedium,
      ),
      child: ListenableBuilder(
        listenable: Listenable.merge(listanableList),
        builder: (context, widget) {
          return TfbFilledButton.primaryTextButton(
            onPressed: _enabledOnPressed() ? onPressed : null,
            title: context.getLocalizationOf.nextButtonText,
          );
        },
      ),
    );
  }

  bool _enabledOnPressed() {
    return listanableList.every((element) => element.value);
  }
}
