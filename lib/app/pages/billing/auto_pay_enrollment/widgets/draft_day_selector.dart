import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

class DraftDaySelector extends StatelessWidget {
  const DraftDaySelector({
    required this.draftDay,
    super.key,
  });

  final TextEditingController draftDay;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: ValidatingFormField(
        labelText: context.getLocalizationOf.autopayRequestedDraftDayLabel,
        semanticsLabel: context.getLocalizationOf.inputField(
          context.getLocalizationOf.autopayRequestedDraftDayLabel,
        ),
        type: ValidationType.selection,
        readOnly: true,
        isRequired: true,
        controller: draftDay,
        style: context.tfbText.bodyLightLarge
            .copyWith(color: TfbBrandColors.blueHighest),
        suffixIcon: ImageIcon(
          AssetImage(TfbAssetStrings.calendarIcon),
          color: TfbBrandColors.blueHighest,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 24,
        ),
        onChanged: (value) => draftDay.text = value,
        onTap: () {
          /// TODO: Replace 'showModalBottomSheet' with a modal that is
          /// compatible with 'GoRouter'.
          showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: context.radii.defaultRadius.topLeft,
                topRight: context.radii.defaultRadius.topRight,
              ),
            ),
            builder: (context) {
              return SafeArea(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: kSpacingExtraSmall,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: kSpacingMedium,
                              ),
                              child: Text(
                                context.getLocalizationOf
                                    .autopayRequestedDraftDayLabel,
                                style: context.tfbText.bodyLightLarge.copyWith(
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
                                height: 24,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Center(
                            child: Wrap(
                              children: List.generate(
                                28,
                                (i) => i + 1,
                              )
                                  .map(
                                    (e) => DraftDayButton(
                                      index: e,
                                      onPressed: () {
                                        draftDay.text = e.toString();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DraftDayButton extends StatelessWidget {
  const DraftDayButton({
    required this.index,
    required this.onPressed,
    super.key,
  });

  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        overlayColor: MaterialStatePropertyAll(Color(0x80CAE2F1)),
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        index.toString(),
        style: context.tfbText.bodyMediumSmall
            .copyWith(color: TfbBrandColors.blueHigh),
      ),
    );
  }
}
