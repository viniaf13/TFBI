import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_information_item.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/homeowner_policy_detail.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class DiscountsSection extends StatelessWidget {
  const DiscountsSection({
    required this.discounts,
    super.key,
  });

  final List<HomeownerDiscount> discounts;

  @override
  Widget build(BuildContext context) {
    return PolicyDetailInformationItem(
      title: context.getLocalizationOf.discountsCoverageLabel,
      children: discounts
          .map(
            (discount) => Text(
              discount.name,
              style: context.tfbText.bodyRegularSmall,
            ),
          )
          .toList(),
    );
  }
}
