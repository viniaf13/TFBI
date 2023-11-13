import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_image.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class PolicyCardHeader extends StatelessWidget {
  const PolicyCardHeader(this.summaryItem, {super.key, this.isDetail = false});

  factory PolicyCardHeader.overview(PolicySummary summaryItem, {Key? key}) {
    return PolicyCardHeader(
      summaryItem,
      key: key,
      isDetail: true,
    );
  }

  final PolicySummary summaryItem;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDetail) ...[
              Text(
                summaryItem.policyType.name(context),
                style: context.tfbText.header3
                    .copyWith(color: TfbBrandColors.blueHighest),
              ),
              Text(
                '#${summaryItem.policyNumber}',
                style: context.tfbText.bodyRegularLarge
                    .copyWith(color: TfbBrandColors.blueHighest),
              ),
            ],
            if (!isDetail) ...[
              Text(
                summaryItem.policyType.name(context),
                style: context.tfbText.bodyMediumSmall
                    .copyWith(color: TfbBrandColors.blueHighest),
              ),
              Text(
                '#${summaryItem.policyNumber}',
                style: context.tfbText.subHeaderLight
                    .copyWith(color: TfbBrandColors.blueHighest),
              ),
            ],
          ],
        ),
        PolicyImage(
          summaryItem.policyType,
          height: 42,
        ),
      ],
    );
  }
}
