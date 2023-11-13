import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_typography.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';

import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class TimeOfLossFormField extends StatefulWidget {
  const TimeOfLossFormField({
    required this.controller,
    required this.onChanged,
    required this.dateOfLoss,
    required this.validator,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String value) onChanged;
  final String dateOfLoss;
  final String? Function(String? value)? validator;

  @override
  State<TimeOfLossFormField> createState() => _TimeOfLossFormFieldState();
}

class _TimeOfLossFormFieldState
    extends FocusAwareWidgetState<TimeOfLossFormField> {
  bool isModalOpened = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isModalOpened;
      },
      child: ValidatingFormField(
        type: ValidationType.selection,
        key: formFieldKey,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        isRequired: true,
        readOnly: true,
        controller: widget.controller,
        autoFillHints: const [AutofillHints.name],
        onTap: () async {
          await getTimeOfDay();
          isModalOpened = false;
        },
        labelText: context.getLocalizationOf.timeOfLossTextFormField,
        suffixIcon: Image.asset(
          TfbAssetStrings.clockIcon,
          height: 25,
          width: 25,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 25,
          maxWidth: 25,
        ),
      ),
    );
  }

  Future<void> getTimeOfDay() async {
    isModalOpened = true;

    final timePickerTheme = ThemeData(
      useMaterial3: true,
      fontFamily: TfbTypography.brandFontFamily,
      dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.transparent,
      ),
      colorSchemeSeed: TfbBrandColors.blueHighest,
      splashFactory: NoSplash.splashFactory,
      timePickerTheme: TimePickerThemeData(
        hourMinuteTextColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TfbBrandColors.white;
          } else {
            return TfbBrandColors.blueHighest;
          }
        }),
        hourMinuteColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TfbBrandColors.blueHighest;
          } else {
            return TfbBrandColors.grayLow;
          }
        }),
        dialBackgroundColor: TfbBrandColors.grayLow,
        dialHandColor: TfbBrandColors.blueHighest,
        dayPeriodTextColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TfbBrandColors.white;
          } else {
            return TfbBrandColors.blueHighest;
          }
        }),
        dayPeriodColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return TfbBrandColors.blueHighest;
          } else {
            return TfbBrandColors.grayLow;
          }
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          foregroundColor:
              MaterialStateProperty.all(TfbBrandColors.blueHighest),
          textStyle: MaterialStateProperty.all(context.tfbText.bodyMediumLarge),
        ),
      ),
    );

    final selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context),
          child: Theme(
            data: timePickerTheme,
            child: child!,
          ),
        );
      },
    );

    // If the chosen date of loss is the current day and the entered time is in the future,
    // the chosen time will be set to the current time.
    if (selectedTime != null) {
      final month = int.parse(widget.dateOfLoss.split('/')[0]);
      final day = int.parse(widget.dateOfLoss.split('/')[1]);
      final year = int.parse(widget.dateOfLoss.split('/')[2]);

      var date = DateTime(
        year,
        month,
        day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (date.isAfter(DateTime.now())) {
        date = DateTime.now();
      }

      final timeStringFormatted = DateFormat.jm().format(date);
      widget.controller.text = timeStringFormatted;
      widget.onChanged(date.toIso8601String());
    }
    validateOnNextFrame();
  }
}
