import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_details_widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_section_header_view.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class ClaimDetailsClaimsSection extends StatelessWidget {
  const ClaimDetailsClaimsSection({
    required this.claims,
    required this.section,
    required this.padding,
    super.key,
  });

  final Iterable<FullClaim?> claims;
  final ClaimsSection section;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (claims.isNotEmpty) {
      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClaimsSectionHeaderView(section),
            Column(
              children: claims
                  .map(
                    (claim) => Column(
                      children: [
                        if (claim != null) ClaimDetailsCard(claim: claim),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
