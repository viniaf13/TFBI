part of '../policies_section.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard(this.summary, this.detail, {super.key});

  final PolicySummary summary;
  final PolicyDetail? detail;

  String _formattedDate(String date) {
    final DateFormat serverFormat = DateFormat('yyyy-MM-dd');
    final dateTime = serverFormat.parse(date);
    final DateFormat displayFormat = DateFormat('M/yyyy');
    return displayFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpacingMedium),
      decoration: ShapeDecoration(
        color: TfbBrandColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: context.radii.defaultRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PolicyCardHeader(summary),
          const SeparatorLine(
            padding: EdgeInsets.symmetric(vertical: kSpacingMedium),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (detail != null)
                Expanded(child: _policyDetails(summary, detail!)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.getLocalizationOf.expires,
                    style: context.tfbText.caption,
                  ),
                  Text(
                    _formattedDate(summary.policyExpirationDate),
                    style: context.tfbText.bodyRegularLarge,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSpacingMedium),
            child: PolicyPaymentLabel(
              policySummary: summary,
            ),
          ),
          PolicyClaimsLabel(
            policySummary: summary,
          ),
          const SizedBox(
            height: kSpacingMedium,
          ),
          PolicyCardButtons(
            summary: summary,
          ),
        ],
      ),
    );
  }

  Widget _policyDetails(PolicySummary summary, PolicyDetail policyDetail) {
    if (summary.policyType == PolicyType.txPersonalAuto) {
      return PersonalAutoPolicyVehicleList(policyDetail as AutoPolicyDetail);
    } else {
      return PolicyCardAddress(policyDetail);
    }
  }
}
