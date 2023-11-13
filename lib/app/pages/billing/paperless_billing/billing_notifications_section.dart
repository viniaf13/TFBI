import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class BillingNotificationsSection extends StatelessWidget {
  const BillingNotificationsSection({
    required this.sectionTitle,
    required this.infoSection,
    this.isEnabled = true,
    super.key,
  });

  factory BillingNotificationsSection.disabled(String sectionTitle) =>
      BillingNotificationsSection(
        sectionTitle: sectionTitle,
        isEnabled: false,
        infoSection: null,
      );

  final String sectionTitle;
  final Widget? infoSection;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: context.tfbText.bodyMediumSmall,
            ),
            if (isEnabled)
              Text(
                context.getLocalizationOf.enabledLabel,
                style: context.tfbText.bodyMediumSmall
                    .copyWith(color: TfbBrandColors.greenHighest),
              )
            else
              Text(
                context.getLocalizationOf.disabledLabel,
                style: context.tfbText.bodyMediumSmall
                    .copyWith(color: TfbBrandColors.redHighest),
              ),
          ],
        ),
        if (isEnabled && infoSection != null) infoSection!,
      ],
    );
  }
}
