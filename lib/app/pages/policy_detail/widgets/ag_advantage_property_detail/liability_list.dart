import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/expandable_property_item.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LiabilityList extends StatelessWidget {
  const LiabilityList({required this.sections, super.key});

  final List<AgAdvantageSection> sections;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.getLocalizationOf.liabilityCoverageLabel,
          style: context.tfbText.bodyMediumLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: kSpacingExtraSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sections.map(ExpandablePropertyItem.new).toList(),
          ),
        ),
      ],
    );
  }
}
