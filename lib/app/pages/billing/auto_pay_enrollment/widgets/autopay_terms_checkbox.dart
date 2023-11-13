import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AutopayTermsCheckbox extends StatelessWidget {
  const AutopayTermsCheckbox({required this.checked, super.key});

  final ValueNotifier<bool> checked;

  @override
  Widget build(BuildContext context) {
    bool hasBeenTapped = false;

    void onTap() {
      checked.value = !checked.value;
      hasBeenTapped = true;
    }

    return ValueListenableBuilder(
      valueListenable: checked,
      builder: (context, value, child) => Semantics(
        checked: value,
        excludeSemantics: true,
        onTap: onTap,
        button: true,
        label: context.getLocalizationOf.autopayTermsAndConditions,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kSpacingMedium),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: kSpacingMedium,
                      ),
                      height: 18,
                      width: 18,
                      child: Stack(
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              color: TfbBrandColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: context.radii.tiny,
                                side: const BorderSide(
                                  width: 2,
                                  color: TfbBrandColors.grayMedium,
                                ),
                              ),
                            ),
                          ),
                          if (value) ...[
                            Image.asset(
                              TfbAssetStrings.checkmarkIcon,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        context.getLocalizationOf.autopayTermsAndConditions,
                        style: context.tfbText.bodyMediumSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (hasBeenTapped && !checked.value)
              Padding(
                padding: const EdgeInsets.only(top: kSpacingExtraSmall),
                child: Text(
                  context.getLocalizationOf.autopayTermsErrorMessage,
                  style: context.tfbText.caption
                      .copyWith(color: TfbBrandColors.redHigh),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
