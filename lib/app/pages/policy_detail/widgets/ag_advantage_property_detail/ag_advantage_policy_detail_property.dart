import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/discounts_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/liability_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/mortgagees_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card_title.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

class AgAdvantagePolicyDetailProperty extends StatelessWidget {
  const AgAdvantagePolicyDetailProperty({required this.details, super.key});

  final AgAdvantagePolicyDetail details;

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      headerContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PolicyDetailCardTitle(
            title: context.getLocalizationOf.propertyCardTitle,
          ),
          AddressWidget(
            address: details.fullAddress!,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      expandableSectionLabel: Text(
        context.getLocalizationOf.coverageInformationCta,
        style: context.tfbText.bodyMediumSmall.copyWith(
          color: TfbBrandColors.blueHighest,
        ),
      ),
      expandableSectionContent: [
        LiabilityList(
          sections: details.sections
              .where(
                (section) =>
                    section.coverages.isNotEmpty ||
                    section.deductibles.isNotEmpty,
              )
              .toList(),
        ),
        DiscountsList(
          discounts:
              details.sections.expand((section) => section.discounts).toList(),
        ),
        MortgageesList(
          mortgagees:
              details.sections.expand((section) => section.mortgagees).toList(),
        ),
      ],
    );
  }
}
