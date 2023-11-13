import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/ebill_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_notifications_section.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class BillingEbillLookupConsumer extends StatelessWidget {
  const BillingEbillLookupConsumer({
    required this.policy,
    super.key,
  });

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    Widget returnWidget = const SizedBox();
    // Processing state handle in UI layer
    return BlocConsumer<EbillLookupCubit, EbillLookUpState>(
      listener: (context, state) {
        if (state is EbillLookUpFailureState) {
          context.showErrorSnackBar(
            text: state.error.message,
          );
        }
      },
      builder: (context, state) {
        if (state is EbillLookUpInitState) {
          context.read<EbillLookupCubit>().getEbillNotificationDetails(policy);
        }

        if (state is EbillLookUpSuccessState) {
          final phoneNumber =
              (state.response.memberPhoneNumber as String).formatPhoneNumber();
          returnWidget = BillingNotificationsSection(
            sectionTitle: context.getLocalizationOf.ebillTextNotifications,
            infoSection: Text(
              '${context.getLocalizationOf.sendToLabel} $phoneNumber',
              style: context.tfbText.bodyRegularSmall
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          );
        }

        if (state is EbillLookUpFailureState) {
          returnWidget = BillingNotificationsSection(
            sectionTitle: context.getLocalizationOf.ebillTextNotifications,
            infoSection: Text(
              context.getLocalizationOf.errorLoadingPhoneNumber,
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
