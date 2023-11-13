import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_card_header.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyListItem extends StatelessWidget {
  const PolicyListItem(this.summaryItem, this.summaryCta, {super.key});

  final PolicySummary summaryItem;
  final TfbFilledButton summaryCta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpacingMedium),
      decoration: BoxDecoration(
        color: TfbBrandColors.white,
        borderRadius: context.radii.defaultRadius,
      ),
      child: Column(
        children: [
          PolicyCardHeader(summaryItem),
          const SizedBox(height: kSpacingMedium),
          summaryCta,
        ],
      ),
    );
  }
}
