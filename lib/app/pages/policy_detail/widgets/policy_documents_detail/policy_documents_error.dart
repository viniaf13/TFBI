import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyDocumentsError extends StatelessWidget {
  const PolicyDocumentsError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingMedium),
            child: Text(
              context.getLocalizationOf.policyDocumentsCardTitle,
              style: context.tfbText.header3
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          ),
          Text(
            context.getLocalizationOf.errorLoadingDocuments,
            style: context.tfbText.bodyRegularSmall.copyWith(
              color: TfbBrandColors.redHigh,
            ),
          ),
        ],
      ),
    );
  }
}
