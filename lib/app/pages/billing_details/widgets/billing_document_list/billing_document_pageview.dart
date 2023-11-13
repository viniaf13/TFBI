import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_page_view_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_document_list/billing_document_list_item.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/utils/slices.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_page_view.dart';

class BillingDocumentPageView extends StatelessWidget {
  const BillingDocumentPageView({
    required this.pageViewController,
    required this.billingDocuments,
    required this.pageSize,
    super.key,
  });

  final PageController pageViewController;
  final List<BillingListMetadata> billingDocuments;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final slices = billingDocuments.slices(pageSize).toList();

    return ExpandablePageView(
      controller: pageViewController,
      itemCount: (billingDocuments.length / pageSize).ceil(),
      pageBuilder: (context, index) => BillingPageViewPage(
        items: slices[index],
        itemBuilder: (item) => BillingDocumentListItem(
          item: item,
          isFirst: item == slices[index].first,
          isLast: item == slices[index].last,
        ),
      ),
      useMaxHeight: true,
      minHeight: 54,
    );
  }
}
