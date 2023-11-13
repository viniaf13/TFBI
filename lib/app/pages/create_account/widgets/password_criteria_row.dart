import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PasswordCriteriaRow extends StatelessWidget {
  const PasswordCriteriaRow({
    required this.labelText,
    required this.isCriteriaMet,
    super.key,
  });

  final bool isCriteriaMet;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpacingSmall),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: kSpacingSmall),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isCriteriaMet
                    ? LightColors.greenHighLight
                    : TfbBrandColors.grayHigh,
              ),
            ),
          ),
          Expanded(
            child: Text(
              labelText,
              style: context.tfbText.bodyMediumSmall,
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
