import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class VehicleListItemContent extends StatelessWidget {
  const VehicleListItemContent({required this.vehicle, super.key});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${vehicle.year} ${vehicle.make} ${vehicle.model}',
          style: context.tfbText.bodyMediumLarge
              .copyWith(color: TfbBrandColors.grayHighest),
        ),
        Padding(
          padding: const EdgeInsets.only(left: kSpacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${context.getLocalizationOf.vehiclesVINLabel}:'
                      ' ${vehicle.vin}',
                      style: context.tfbText.bodyRegularLarge,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${context.getLocalizationOf.vehiclesCurrentPremiumLabel}:'
                      ' \$${vehicle.totalVehiclePremium}',
                      style: context.tfbText.bodyRegularLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
