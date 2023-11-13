import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_enable_autopay_cta.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_widgets.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/policy_details_cta_row.dart';

class PolicyDetailOverview extends StatelessWidget {
  const PolicyDetailOverview(
    this.summary,
    this.detail,
    this.footer, {
    super.key,
  });

  factory PolicyDetailOverview.policy(
    PolicySummary summary,
    PolicyDetail detail,
  ) =>
      PolicyDetailOverview(
        summary,
        detail,
        detail is AutoPolicyDetail
            ? [
                const SeparatorLine(),
                BlocProvider(
                  create: (context) => PaperlessLookupCubit(
                    repository: context.read<TfbPolicyLookupRepository>(),
                  ),
                  child: PaperlessEnrollmentRow(
                    isEnabled: detail.isEnrolledPaperless,
                    policySummary: summary,
                  ),
                ),
              ]
            : List.empty(),
      );

  factory PolicyDetailOverview.billing(
    PolicySummary summary,
    PolicyDetail? detail,
  ) =>
      PolicyDetailOverview(
        summary,
        detail,
        summary.isAutopaySupported && !summary.isAutoPayEnabled
            ? [
                const SeparatorLine(
                  padding: EdgeInsets.only(top: kSpacingMedium),
                ),
                BillingEnableAutoPayCta(policy: summary),
              ]
            : List.empty(),
      );

  final PolicySummary summary;
  final PolicyDetail? detail;
  final List<Widget> footer;

  String _formattedDate(String? date) {
    final DateFormat serverFormat = DateFormat('yyyy-MM-dd');
    final dateTime = serverFormat.parse(date!);
    final DateFormat displayFormat = DateFormat('M/dd/yyyy');
    return displayFormat.format(dateTime);
  }

  String get _policyPeriodDescription {
    final start =
        _formattedDate(detail?.effectiveDate ?? summary.policyEffectiveDate);
    final finish =
        _formattedDate(detail?.expirationDate ?? summary.policyExpirationDate);

    return '$start - $finish';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PolicyCardHeader.overview(summary),
        const SeparatorLine(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.getLocalizationOf.policyPeriodCaption,
              style: context.tfbText.caption,
            ),
            Text(
              _policyPeriodDescription,
              style: context.tfbText.bodyRegularLarge,
            ),
            const SizedBox(height: kSpacingSmall),
            PolicyOverviewRowItem(
              icon: TfbAssetStrings.arrowRightIcon,
              title: context.getLocalizationOf.balanceDueCaption,
              value: summary.policyMinimumAmountDue
                  .formatCurrency(showDecimal: true),
            ),
            PolicyOverviewRowItem(
              icon: TfbAssetStrings.calendarIcon,
              title: context.getLocalizationOf.nextDueDateCaption,
              value: _formattedDate(summary.policyDueDate),
            ),
            PolicyOverviewRowItem(
              icon: TfbAssetStrings.billIcon,
              title: context.getLocalizationOf.remainingBalanceCaption,
              value: summary.policyMaximumAmountDue
                  .formatCurrency(showDecimal: true),
            ),
            PolicyDetailsCtaRow(policySummary: summary),
          ],
        ),
        if (footer.isNotEmpty) ...footer,
      ],
    );
  }
}
