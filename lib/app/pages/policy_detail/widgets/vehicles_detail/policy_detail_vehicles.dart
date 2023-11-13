import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/expandable_vehicle_list_item_card.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyDetailVehicles extends StatelessWidget {
  const PolicyDetailVehicles({required this.details, super.key});

  final AutoPolicyDetail details;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: kSpacingMedium,
            left: kSpacingMedium,
            right: kSpacingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.getLocalizationOf.vehiclesCardTitle,
                style: context.tfbText.header3
                    .copyWith(color: TfbBrandColors.blueHighest),
              ),
              const SeparatorLine(
                padding: EdgeInsets.only(
                  top: kSpacingMedium,
                ),
              ),
            ],
          ),
        ),
        Column(
          children:
              details.vehicles.map(ExpandableVehicleListItemCard.new).toList(),
        ),
      ],
    );
  }
}
