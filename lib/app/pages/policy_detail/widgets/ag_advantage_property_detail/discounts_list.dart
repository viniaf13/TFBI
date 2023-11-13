import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_information_item.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DiscountsList extends StatelessWidget {
  const DiscountsList({required this.discounts, super.key});

  final List<AgAdvantageDiscount> discounts;

  @override
  Widget build(BuildContext context) {
    return PolicyDetailInformationItem(
      title: context.getLocalizationOf.discountsCoverageLabel,
      children: discounts.map((discount) {
        return Text(
          discount.name,
          style: context.tfbText.bodyRegularSmall,
        );
      }).toList(),
    );
  }
}
