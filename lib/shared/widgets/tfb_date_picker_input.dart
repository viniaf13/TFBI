import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_typography.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';
import 'package:plugin_haven/plugin_haven.dart';

class TfbDatePickerInput extends StatefulWidget {
  const TfbDatePickerInput({
    required this.controller,
    required this.inputLabel,
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  final TextEditingController controller;
  final String inputLabel;

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  State<TfbDatePickerInput> createState() => _TfbDatePickerInputState();
}

class _TfbDatePickerInputState extends State<TfbDatePickerInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isModalOpened = false;

    return WillPopScope(
      onWillPop: () async {
        return !isModalOpened;
      },
      child: Semantics(
        label: context.getLocalizationOf.selectionField(widget.inputLabel),
        child: ValidatingFormField(
          additionalValidator: (value) {
            if (value.isNullOrEmpty) {
              return context.getLocalizationOf.selectedFieldValidation(
                context.getLocalizationOf.dateOfLoss.toLowerCase(),
              );
            }
            return null;
          },
          isRequired: true,
          suffixIcon: Image.asset(
            TfbAssetStrings.calendarIcon,
            height: 24,
            width: 24,
            color: TfbBrandColors.blueHighest,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 24,
            maxWidth: 24,
          ),
          labelText: widget.inputLabel,
          type: ValidationType.selection,
          style: context.tfbText.bodyLightLarge
              .copyWith(color: TfbBrandColors.blueHighest),
          controller: widget.controller,
          readOnly: true,
          onTap: () async {
            isModalOpened = true;
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: widget.initialDate ?? DateTime.now(),
              firstDate: widget.firstDate ??
                  DateTime.utc(
                    DateTime.now().year - 2,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
              lastDate: widget.lastDate ?? DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: ThemeData(
                    useMaterial3: true,
                    fontFamily: TfbTypography.brandFontFamily,
                    colorSchemeSeed: TfbBrandColors.blueHighest,
                    splashFactory: NoSplash.splashFactory,
                    datePickerTheme: DatePickerThemeData(
                      backgroundColor: TfbBrandColors.white,
                      surfaceTintColor: Colors.transparent,
                      todayBorder: BorderSide.none,
                      todayBackgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return TfbBrandColors.blueHighest;
                        }
                        return null;
                      }),
                      dayBackgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return TfbBrandColors.blueHighest;
                        }
                        return null;
                      }),
                      headerForegroundColor: TfbBrandColors.blueHighest,
                      headerHeadlineStyle: context.tfbText.header3,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        foregroundColor: MaterialStateProperty.all(
                          TfbBrandColors.blueHighest,
                        ),
                        textStyle: MaterialStateProperty.all(
                          context.tfbText.bodyMediumLarge,
                        ),
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            isModalOpened = false;

            if (pickedDate != null) {
              final String formattedDate =
                  DateFormat('MM/dd/yyyy').format(pickedDate);
              setState(() {
                widget.controller.text = formattedDate;
              });
            }
          },
        ),
      ),
    );
  }
}
