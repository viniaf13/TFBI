import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_payment_list/billing_payment_list_builder.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/card_title.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/page_view_controls.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BillingPaymentListContainer extends StatefulWidget {
  const BillingPaymentListContainer({
    required this.policy,
    super.key,
  });

  final PolicySummary policy;

  @override
  State<BillingPaymentListContainer> createState() =>
      _BillingPaymentListContainerState();
}

class _BillingPaymentListContainerState
    extends State<BillingPaymentListContainer> {
  final pageViewController = PageController();
  final pageSize = 5;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      // Updates the PageViewControls currentPage
      setState(() {});
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num currentPage;

    try {
      currentPage = ((pageViewController.page ?? 0) + 1).round();
    } catch (_) {
      currentPage = 1;
    }

    return BlocBuilder<MemberSummaryCubit, MemberSummaryState>(
      builder: (context, state) {
        int paymentPageLength = 0;
        if (state is MemberSummaryDetailsSuccess) {
          final policyDetail = state.policyMap[widget.policy.policyNumber];
          final paymentHistory = policyDetail?.policyBilling.paymentHistory;
          paymentPageLength = ((paymentHistory?.length ?? 0) / pageSize).ceil();
        }

        return Card(
          margin: EdgeInsets.zero,
          semanticContainer: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(
                title: context.getLocalizationOf.paymentHistoryContainerTitle,
              ),
              BillingPaymentsListBuilder(
                pageViewController: pageViewController,
                pageSize: pageSize,
                policy: widget.policy,
              ),
              if (state is MemberSummaryProcessing ||
                  (state is MemberSummaryDetailsSuccess &&
                      paymentPageLength != 0))
                PageViewControls(
                  pageViewController: pageViewController,
                  currentPage: currentPage,
                  showPageCount: state is MemberSummaryDetailsSuccess,
                  maxPages: paymentPageLength,
                ),
            ],
          ),
        );
      },
    );
  }
}
