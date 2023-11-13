import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ClaimDetailsCardHeader extends StatelessWidget {
  const ClaimDetailsCardHeader({
    required this.policyType,
    required this.claimStatus,
    required this.claimNumber,
    required this.claimIcon,
    this.withPadding = true,
    super.key,
  });

  final PolicyType? policyType;
  final ClaimStatusEnum? claimStatus;
  final String claimNumber;
  final String claimIcon;
  final bool withPadding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: LightColors.surface,
        borderRadius: context.radii.defaultRadiusTop,
      ),
      child: Container(
        padding: withPadding
            ? const EdgeInsets.all(kSpacingMedium)
            : EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${policyType?.name(context)} - ',
                        style: context.tfbText.bodyMediumSmall.copyWith(
                          color: TfbBrandColors.blueHighest,
                        ),
                      ),
                      TextSpan(
                        text: claimStatus?.name(context),
                        style: context.tfbText.bodyMediumSmall.copyWith(
                          color: (claimStatus != ClaimStatusEnum.inactive)
                              ? TfbBrandColors.greenHighest
                              : TfbBrandColors.grayHigh,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  claimNumber,
                  style: context.tfbText.subHeaderLight.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
              ],
            ),
            Image.asset(claimIcon, height: 42),
          ],
        ),
      ),
    );
  }
}
