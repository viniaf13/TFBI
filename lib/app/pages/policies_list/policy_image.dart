import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyImage extends StatelessWidget {
  const PolicyImage(this.policyType, {super.key, this.height});

  final PolicyType policyType;
  final double? height;

  @override
  Widget build(BuildContext context) {
    switch (policyType) {
      case PolicyType.homeowners:
        return Image.asset(
          height: height,
          TfbAssetStrings.homePolicyIcon,
        );
      case PolicyType.txPersonalAuto:
        return Image.asset(
          height: height,
          TfbAssetStrings.autoPolicyIcon,
        );
      case PolicyType.agAdvantage:
        return Image.asset(
          height: height,
          TfbAssetStrings.farmPolicyIcon,
        );
      case _:
        return Container();
    }
  }
}
