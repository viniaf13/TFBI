import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/enum/widget_location_enum.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list_item.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

class BillingCard extends StatelessWidget {
  const BillingCard({
    required this.policySummary,
    required this.policyBilling,
    super.key,
  });
  final PolicySummary policySummary;

  final PolicyBilling policyBilling;

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
      headerContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.getLocalizationOf.billingTitle,
            style: context.tfbText.header3
                .copyWith(color: TfbBrandColors.blueHighest),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kSpacingMedium),
            child: Row(
              children: [
                Expanded(
                  child: TfbFilledButton.primaryTextButton(
                    onPressed: () {
                      context.navigator.pushBillingDetailPage(
                        policySummary,
                        location: WidgetLocationEnum.paymentHistory.name,
                      );
                    },
                    title: context.getLocalizationOf.paymentHistory,
                    style: context.tfbText.bodyMediumSmall.copyWith(
                      color: TfbBrandColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: kSpacingSmall),
                Expanded(
                  child: TfbFilledButton.primaryTextButton(
                    onPressed: () {
                      context.navigator.pushBillingDetailPage(
                        policySummary,
                        location: WidgetLocationEnum.billingDocuments.name,
                      );
                    },
                    title: context.getLocalizationOf.billingDocuments,
                    style: context.tfbText.bodyMediumSmall.copyWith(
                      color: TfbBrandColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      expandableSectionLabel: Text(
        context.getLocalizationOf.details,
        style: context.tfbText.bodyMediumSmall.copyWith(
          color: TfbBrandColors.blueHighest,
        ),
      ),
      expandableSectionContent: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSpacingSmall),
          child: Text(
            context.getLocalizationOf.premiumForCurrentPolicy,
            style: context.tfbText.bodyMediumLarge,
          ),
        ),
        DualColorList(
          items: policyBilling.mapPremiumForCurrentPolicy.entries
              .map(
                (item) => DualColorListItem(
                  label: item.key,
                  values: [item.value],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
