import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_liability_item.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_section_content.dart';

class ExpandablePropertyItem extends StatelessWidget {
  const ExpandablePropertyItem(this.agAdvantageSection, {super.key});

  final AgAdvantageSection agAdvantageSection;

  @override
  Widget build(BuildContext context) {
    return ExpandableSectionContent(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      iconColor: TfbBrandColors.grayHighest,
      title: Text(
        agAdvantageSection.name,
        style: context.tfbText.bodyRegularLarge,
      ),
      children: [_showLiabilityList(context)],
    );
  }

  Widget _showLiabilityList(BuildContext context) {
    return DualColorList(
      items: [
        ...agAdvantageSection.coverages.map((coverage) {
          return PolicyDetailLiabilityItem(
            label: coverage.coverageLabel,
            value: coverage.limit,
          );
        }),
        ...agAdvantageSection.deductibles.map((deductible) {
          return PolicyDetailLiabilityItem(
            label: deductible.name,
            value: deductible.amount,
          );
        }),
      ],
    );
  }
}
