import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BankAccountSelector extends StatelessWidget {
  const BankAccountSelector({required this.accountType, super.key});

  final ValueNotifier<AutopayAccountType?> accountType;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: accountType,
      builder: (context, value, child) {
        void onTapCheckings() {
          accountType.value = AutopayAccountType.checkings;
        }

        void onTapSavings() {
          accountType.value = AutopayAccountType.savings;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: kSpacingMedium,
                bottom: kSpacingSmall,
              ),
              child: Text(
                context.getLocalizationOf.autopayAccountTypeHeader,
                style: context.tfbText.subHeaderRegular.copyWith(
                  color: TfbBrandColors.blueHighest,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(-14, 0),
              child: Column(
                children: [
                  Semantics(
                    checked: value == AutopayAccountType.checkings,
                    button: true,
                    excludeSemantics: true,
                    label: context.getLocalizationOf.autopayCheckingLabel,
                    onTap: onTapCheckings,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onTapCheckings,
                      child: Row(
                        children: [
                          Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return TfbBrandColors.blueHighest;
                              }
                              return TfbBrandColors.grayMedium;
                            }),
                            splashRadius: 0.01,
                            value: AutopayAccountType.checkings,
                            groupValue: accountType.value,
                            onChanged: (value) => accountType.value = value!,
                          ),
                          Text(
                            context.getLocalizationOf.autopayCheckingLabel,
                            style: context.tfbText.bodyMediumSmall.copyWith(
                              color: TfbBrandColors.blueHighest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Semantics(
                    checked: value == AutopayAccountType.savings,
                    button: true,
                    excludeSemantics: true,
                    label: context.getLocalizationOf.autopaySavingsLabel,
                    onTap: onTapSavings,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onTapSavings,
                      child: Row(
                        children: [
                          Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return TfbBrandColors.blueHighest;
                              }
                              return TfbBrandColors.grayMedium;
                            }),
                            splashRadius: 0.01,
                            value: AutopayAccountType.savings,
                            groupValue: accountType.value,
                            onChanged: (value) => accountType.value = value!,
                          ),
                          Text(
                            context.getLocalizationOf.autopaySavingsLabel,
                            style: context.tfbText.bodyMediumSmall.copyWith(
                              color: TfbBrandColors.blueHighest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
