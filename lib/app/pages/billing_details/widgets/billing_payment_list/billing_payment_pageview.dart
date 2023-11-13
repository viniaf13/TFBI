import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_page_view_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_payment_list/billing_payment_list_item.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/utils/slices.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_page_view.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class BillingPaymentPageView extends StatelessWidget {
  const BillingPaymentPageView({
    required this.pageViewController,
    required this.billingDocuments,
    required this.pageSize,
    super.key,
  });

  final PageController pageViewController;
  final List<BillingPaymentViewModel> billingDocuments;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final slices = billingDocuments.slices(pageSize).toList();

    return ExpandablePageView(
      controller: pageViewController,
      itemCount: (billingDocuments.length / pageSize).ceil(),
      pageBuilder: (context, index) => BillingPageViewPage(
        items: slices[index],
        itemBuilder: BillingPaymentItem.new,
      ),
      useMaxHeight: true,
      minHeight: 54,
    );
  }
}

class BillingPaymentViewModel {
  BillingPaymentViewModel({
    required this.title,
    required this.date,
    required this.paymentAmount,
  });

  factory BillingPaymentViewModel.fromPaymentHistory(
    PaymentHistory paymentHistory,
  ) =>
      BillingPaymentViewModel(
        title: paymentHistory.description ?? '',
        date: paymentHistory.paymentDate ?? '',
        paymentAmount: double.tryParse(paymentHistory.paymentAmount ?? '') ?? 0,
      );

  String title;
  String date;
  double paymentAmount;
}
