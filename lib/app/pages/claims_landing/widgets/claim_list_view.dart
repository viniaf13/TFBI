import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_card/claim_details_claims_section.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_section_header_view.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/utils/list_partition.dart';

class ClaimListView extends StatelessWidget {
  const ClaimListView(this.claims, {super.key});

  final List<FullClaim?> claims;

  @override
  Widget build(BuildContext context) {
    final partitioned = partition(
      claims,
      test: (claim) => claim?.statusEnum == ClaimStatusEnum.active,
    );

    return Padding(
      padding: const EdgeInsets.only(
        bottom: kSpacingMedium,
      ),
      child: Column(
        children: [
          ClaimDetailsClaimsSection(
            padding: const EdgeInsets.only(
              top: kSpacingLarge,
            ),
            claims: partitioned.first,
            section: ClaimsSection.active,
          ),
          ClaimDetailsClaimsSection(
            padding: const EdgeInsets.only(
              top: kSpacingLarge,
            ),
            claims: partitioned.last,
            section: ClaimsSection.history,
          ),
        ],
      ),
    );
  }
}
