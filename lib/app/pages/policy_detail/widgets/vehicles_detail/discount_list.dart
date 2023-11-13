import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_information_item.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DiscountList extends StatelessWidget {
  const DiscountList({required this.discounts, super.key});

  final List<Discount> discounts;

  @override
  Widget build(BuildContext context) {
    return PolicyDetailInformationItem(
      title: context.getLocalizationOf.discountsCoverageLabel,
      children: discounts.map((Discount item) {
        return Text(
          item.discountType,
          style: context.tfbText.bodyRegularSmall,
        );
      }).toList(),
    );
  }
}
