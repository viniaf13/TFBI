import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class BottomSheetSelectorOption {
  BottomSheetSelectorOption({
    required this.label,
    required this.value,
  });

  final String label;
  final Object value;
}

class BottomSheetSelector extends StatelessWidget {
  const BottomSheetSelector({
    required this.title,
    required this.options,
    required this.selectedValueController,
    required this.onChanged,
    super.key,
    this.requiredField = false,
    this.validator,
  });

  final String title;
  final void Function(Object) onChanged;

  final List<BottomSheetSelectorOption> options;
  final bool requiredField;
  final TextEditingController selectedValueController;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Semantics(
          label: context.getLocalizationOf.inputField(title),
          child: ValidatingFormField(
            labelText: title,
            type: ValidationType.selection,
            readOnly: true,
            isRequired: requiredField,
            controller: selectedValueController,
            style: context.tfbText.bodyLightLarge
                .copyWith(color: TfbBrandColors.blueHighest),
            suffixIcon: Image.asset(
              TfbAssetStrings.chevronRightIcon,
              width: 24,
              height: 24,
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 24,
              maxWidth: 24,
            ),
            onChanged: onChanged,
            onTap: () {
              /// TODO: Replace showModalBottomSheet
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Wrap(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: GestureDetector(
                          onTap: () {},
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: TfbBrandColors.white,
                              borderRadius: context.radii.defaultRadiusTop,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: kSpacingMedium,
                                      ),
                                      child: Text(
                                        title,
                                        style: context.tfbText.bodyLightLarge
                                            .copyWith(
                                          color: TfbBrandColors.blueHighest,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      alignment: Alignment.centerRight,
                                      icon: Image.asset(
                                        TfbAssetStrings.closeIcon,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: kSpacingMedium,
                                  ),
                                  child: Divider(
                                    height: 1,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.45,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_, index) {
                                      return BottomSheetSelectorOptionButton(
                                        label: options[index].label,
                                        value: options[index].value,
                                        onPress: () {
                                          selectedValueController.text =
                                              options[index].label;
                                          onChanged(
                                            options[index].value,
                                          );
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class BottomSheetSelectorOptionButton extends StatelessWidget {
  const BottomSheetSelectorOptionButton({
    required this.value,
    required this.label,
    required this.onPress,
    super.key,
  });

  final Object value;
  final String label;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpacingLarge,
          vertical: kSpacingSmall,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            label,
            style: context.tfbText.bodyMediumLarge.copyWith(
              color: TfbBrandColors.blueHigh,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
