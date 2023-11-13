import 'package:intl/intl.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_payment_list/billing_payment_pageview.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BillingPaymentItem extends StatelessWidget {
  const BillingPaymentItem(
    this.item, {
    super.key,
  });

  final BillingPaymentViewModel item;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: context.tfbText.caption,
                ),
                Text(
                  item.date,
                  style: context.tfbText.bodyRegularSmall,
                ),
              ],
            ),
            Text(
              formatCurrency.format(item.paymentAmount),
              style: context.tfbText.bodyRegularSmall,
            ),
          ],
        ),
        const SeparatorLine(
          padding: EdgeInsets.symmetric(vertical: kSpacingSmall),
        ),
      ],
    );
  }
}
