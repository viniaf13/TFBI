import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_payment_list/billing_payment_pageview.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class BillingPaymentsListBuilder extends StatelessWidget {
  const BillingPaymentsListBuilder({
    required this.pageViewController,
    required this.pageSize,
    required this.policy,
    super.key,
  });

  final PageController pageViewController;
  final int pageSize;
  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberSummaryCubit, MemberSummaryState>(
      builder: (context, state) {
        if (state is MemberSummaryProcessing) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingLarge),
              child: TfbBrandLoadingIcon(
                thickness: LoadingOverlayThickness.thick,
                size: Size.fromHeight(48),
              ),
            ),
          );
        } else if (state is MemberSummaryFailure) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              kSpacingMedium,
              0,
              kSpacingMedium,
              kSpacingMedium,
            ),
            child: Text(
              context.getLocalizationOf.billingDocumentsLoadError,
              style: context.tfbText.subHeaderRegular
                  .copyWith(color: TfbBrandColors.redHigh),
              textAlign: TextAlign.start,
            ),
          );
        }

        if (state is! MemberSummaryDetailsSuccess) {
          return const SizedBox.shrink();
        }

        final policyDetail = state.policyMap[policy.policyNumber];
        final paymentHistory = policyDetail?.policyBilling.paymentHistory;

        if (paymentHistory?.isEmpty ?? true) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              kSpacingMedium,
              0,
              kSpacingMedium,
              kSpacingMedium,
            ),
            child: Text(
              context.getLocalizationOf.emptyPaymentHistory,
              style: context.tfbText.subHeaderRegular,
              textAlign: TextAlign.start,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: kSpacingSmall),
          child: BillingPaymentPageView(
            pageViewController: pageViewController,
            billingDocuments: paymentHistory!
                .map(BillingPaymentViewModel.fromPaymentHistory)
                .toList()
                .reversed
                .toList(),
            pageSize: pageSize,
          ),
        );
      },
    );
  }
}
