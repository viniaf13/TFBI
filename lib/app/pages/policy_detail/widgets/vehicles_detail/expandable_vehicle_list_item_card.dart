import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicle_list_item_content.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/discount_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/liability_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/lienholders_list.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

class ExpandableVehicleListItemCard extends StatelessWidget {
  const ExpandableVehicleListItemCard(this.vehicle, {super.key});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: context.radii.defaultRadiusTop.copyWith(
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
        color: TfbBrandColors.grayLowest,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSpacingExtraSmall),
        child: ExpandableCard(
          headerContent: VehicleListItemContent(vehicle: vehicle),
          expandableSectionLabel: Text(
            context.getLocalizationOf.coverageInformationCta,
            style: context.tfbText.bodyMediumSmall
                .copyWith(color: TfbBrandColors.blueHighest),
          ),
          expandableSectionContent: [
            LiabilityList(coverages: vehicle.coverages),
            DiscountList(
              discounts: vehicle.discounts,
            ),
            LienholdersList(
              lienHolders: vehicle.lienHolders,
            ),
          ],
        ),
      ),
    );
  }
}
