import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/mortgagees_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/homeowners_property_detail/discounts_section.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/homeowners_property_detail/liability_section.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

class HomeownersPolicyDetailProperty extends StatelessWidget {
  const HomeownersPolicyDetailProperty({required this.details, super.key});

  final HomeownerPolicyDetail details;

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
                context.getLocalizationOf.propertyCardTitle,
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
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: context.radii.defaultRadiusTop.copyWith(
              bottomLeft: const Radius.circular(12),
              bottomRight: const Radius.circular(12),
            ),
            color: TfbBrandColors.grayLowest,
          ),
          child: ExpandableCard(
            headerContent: AddressWidget(
              address: details.fullAddress!,
              fontWeight: FontWeight.w500,
            ),
            headerCrossAxisAlignment: CrossAxisAlignment.start,
            expandableSectionLabel: Text(
              context.getLocalizationOf.coverageInformationCta,
              style: context.tfbText.bodyMediumSmall
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
            expandableSectionContent: <Widget>[
              LiabilitySection(
                sections: details.sections
                    .where(
                      (s) => s.coverages.isNotEmpty || s.deductibles.isNotEmpty,
                    )
                    .toList(),
              ),
              DiscountsSection(
                discounts: details.sections
                    .expand((element) => element.discounts)
                    .toList(),
              ),
              MortgageesList(
                mortgagees: details.sections
                    .expand((element) => element.mortgagees)
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
