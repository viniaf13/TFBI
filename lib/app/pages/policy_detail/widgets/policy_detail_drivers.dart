import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_widgets.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class PolicyDetailDrivers extends StatelessWidget {
  const PolicyDetailDrivers({required this.details, super.key});

  final AutoPolicyDetail details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PolicyDetailCardTitle(
          title: context.getLocalizationOf.policyCoveredDriversTitle,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.coveredDrivers.map(DriverListItem.new).toList(),
        ),
        const SizedBox(height: kSpacingLarge),
        PolicyDetailCardTitle(
          title: context.getLocalizationOf.policyExcludedDriversTitle,
        ),
        if (details.excludedDrivers.isEmpty)
          Text(
            context.getLocalizationOf.emptyExcludedDriversLabel,
            style: context.tfbText.bodyRegularLarge,
          ),
        if (details.excludedDrivers.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details.excludedDrivers
                .map(
                  (driver) => Text(
                    driver.fullName.toTitleCase(),
                    style: context.tfbText.bodyMediumLarge,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
