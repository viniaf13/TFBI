import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_notifications_section.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class BillingPaperlessLookupConsumer extends StatelessWidget {
  const BillingPaperlessLookupConsumer({
    required this.policy,
    super.key,
  });

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    Widget returnWidget = const SizedBox();
    // Processing state handle in UI layer
    return BlocConsumer<PaperlessLookupCubit, PaperlessLookupState>(
      listener: (context, state) {
        if (state is PaperlessLookupFailureState) {
          context.showErrorSnackBar(
            text: state.error.toString(),
          );
        }
      },
      builder: (context, state) {
        if (state is PaperlessLookupInitState) {
          context
              .read<PaperlessLookupCubit>()
              .getPaperlessAccountDetails(policy);
        }

        if (state is PaperlessLookupSuccessState) {
          returnWidget = BillingNotificationsSection(
            sectionTitle: context.getLocalizationOf.paperlessBillingTitle,
            infoSection: Text(
              '${context.getLocalizationOf.sendToLabel} ${state.response.memberEmailAddress}',
              style: context.tfbText.bodyRegularSmall
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          );
        }

        if (state is PaperlessLookupFailureState) {
          returnWidget = BillingNotificationsSection(
            sectionTitle: context.getLocalizationOf.paperlessBillingTitle,
            infoSection: Text(
              context.getLocalizationOf.errorLoadingEmail,
              style: context.tfbText.bodyRegularLarge.copyWith(
                color: TfbBrandColors.redHigh,
              ),
            ),
          );
        }

        return returnWidget;
      },
    );
  }
}
