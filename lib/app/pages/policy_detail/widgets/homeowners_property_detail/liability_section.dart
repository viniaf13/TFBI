import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/dual_color_list/dual_color_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_liability_item.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LiabilitySection extends StatelessWidget {
  const LiabilitySection({
    required this.sections,
    super.key,
  });

  final List<HomeownerSection> sections;

  String _getCoverageLabel(HomeownerCoverage coverage) {
    if (!coverage.group.isNullOrEmpty) {
      return '${coverage.group}. ${coverage.name}';
    }
    return coverage.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSpacingSmall),
          child: Text(
            context.getLocalizationOf.liabilityCoverageLabel,
            textAlign: TextAlign.left,
            style: context.tfbText.bodyMediumLarge,
          ),
        ),
        ...sections.map(
          (section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: kSpacingExtraSmall,
                  ),
                  child: Text(
                    section.name,
                    style: context.tfbText.bodyRegularLarge,
                  ),
                ),
                DualColorList(
                  items: [
                    ...section.coverages.map(
                      (coverage) => PolicyDetailLiabilityItem(
                        label: _getCoverageLabel(coverage),
                        value: coverage.limit,
                      ),
                    ),
                    ...section.deductibles.map(
                      (deductible) => PolicyDetailLiabilityItem(
                        label: deductible.name,
                        value: deductible.amount,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
