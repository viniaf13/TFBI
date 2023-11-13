import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyCardAddress extends StatelessWidget {
  const PolicyCardAddress(this.policyDetail, {super.key});

  final PolicyDetail policyDetail;

  @override
  Widget build(BuildContext context) {
    final address = policyDetail is AgAdvantagePolicyDetail
        ? (policyDetail as AgAdvantagePolicyDetail).propertyLocation
        : (policyDetail as HomeownerPolicyDetail).propertyLocation;
    return Padding(
      padding: const EdgeInsets.only(right: kSpacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.getLocalizationOf.address,
            style: context.tfbText.caption,
          ),
          Text(
            address,
            style: context.tfbText.bodyRegularLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
