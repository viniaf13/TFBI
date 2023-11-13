import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/ebill_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_ebill_lookup_consumer.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_notifications_section.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_paperless_lookup_consumer.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class PaperlessBillingDetails extends StatelessWidget {
  const PaperlessBillingDetails({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getDetailsList(context),
    );
  }

  List<Widget> _getDetailsList(BuildContext context) => _isLoading(context)
      ? [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacingSmall),
            child: TfbBrandLoadingIcon(
              size: Size(48, 48),
              thickness: LoadingOverlayThickness.thick,
            ),
          ),
        ]
      : [
          if (policy.paperlessIsEnabled)
            BillingPaperlessLookupConsumer(policy: policy)
          else
            BillingNotificationsSection.disabled(
              context.getLocalizationOf.paperlessBillingTitle,
            ),
          const SeparatorLine(),
          if (policy.ebillIsEnabled)
            BillingEbillLookupConsumer(policy: policy)
          else
            BillingNotificationsSection.disabled(
              context.getLocalizationOf.ebillTextNotifications,
            ),
        ];
}

bool _isLoading(BuildContext context) =>
    context.watch<PaperlessLookupCubit>().state
        is PaperlessLookupProcessingState ||
    context.watch<EbillLookupCubit>().state is EbillLookUpProcessingState;
