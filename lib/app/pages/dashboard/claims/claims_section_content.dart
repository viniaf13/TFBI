import 'dart:math';

import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_card_header.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class ClaimsSectionContent extends StatelessWidget {
  const ClaimsSectionContent({
    required this.claimsList,
    super.key,
  });

  final List<FullClaim> claimsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: min(claimsList.length, 2) *
              (MediaQuery.textScaleFactorOf(context) * 42 + kSpacingSmall),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: min(claimsList.length, 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: kSpacingSmall),
                child: ClaimDetailsCardHeader(
                  policyType: claimsList[index].policyType,
                  claimStatus: claimsList[index].statusEnum,
                  claimNumber: '#${claimsList[index].claimNumber}',
                  claimIcon: claimsList[index].policyType!.policyTypeIcon(),
                  withPadding: false,
                ),
              );
            },
          ),
        ),
        if (claimsList.length > 2)
          Text(
            '+${claimsList.length - 2} ${context.getLocalizationOf.moreClaims}',
            style: context.tfbText.bodyRegularLarge
                .copyWith(color: TfbBrandColors.blueHighest),
          ),
      ],
    );
  }
}
