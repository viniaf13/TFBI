import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class PolicyPaymentLabel extends StatelessWidget {
  const PolicyPaymentLabel({
    required this.policySummary,
    super.key,
  });

  final PolicySummary policySummary;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Visibility(
        visible: policySummary.currentAmountDueIsNotZero,
        replacement: Text(
          context.getLocalizationOf.noPaymentsDue,
          style: context.tfbText.bodyRegularSmall,
        ),
        child: Visibility(
          visible:
              policySummary.isAutoPayEnabled && !policySummary.paymentIsLate,
          replacement: Text.rich(
            style: context.tfbText.bodyBoldLarge,
            TextSpan(
              children: [
                TextSpan(
                  text: policySummary.paymentIsLate
                      ? context.getLocalizationOf.latePaymentOf
                      : context.getLocalizationOf.nextPayment,
                  style: context.tfbText.bodyRegularSmall.copyWith(
                    color: policySummary.paymentIsLate
                        ? TfbBrandColors.redHigh
                        : null,
                  ),
                ),
                TextSpan(
                  text: ' \$${policySummary.policyMinimumAmountDue} ',
                  style: context.tfbText.bodyBoldSmall.copyWith(
                    color: policySummary.paymentIsLate
                        ? TfbBrandColors.redHigh
                        : null,
                  ),
                ),
                TextSpan(
                  text: policySummary.paymentIsLate
                      ? context.getLocalizationOf.wasDueOn
                      : context.getLocalizationOf.isDueOn,
                  style: context.tfbText.bodyRegularSmall.copyWith(
                    color: policySummary.paymentIsLate
                        ? TfbBrandColors.redHigh
                        : null,
                  ),
                ),
                TextSpan(
                  text: ' ${policySummary.getDueDateMonthDay}.',
                  style: context.tfbText.bodyBoldSmall.copyWith(
                    color: policySummary.paymentIsLate
                        ? TfbBrandColors.redHigh
                        : null,
                  ),
                ),
              ],
            ),
          ),
          child: Text.rich(
            style: context.tfbText.bodyBoldLarge,
            TextSpan(
              children: [
                TextSpan(
                  text: context.getLocalizationOf.autoPay,
                  style: context.tfbText.bodyRegularSmall,
                ),
                TextSpan(
                  text: ' \$${policySummary.policyMinimumAmountDue} ',
                  style: context.tfbText.bodyBoldSmall,
                ),
                TextSpan(
                  text: context.getLocalizationOf.isScheduledFor,
                  style: context.tfbText.bodyRegularSmall,
                ),
                TextSpan(
                  text: ' ${policySummary.getDueDateMonthDay}.',
                  style: context.tfbText.bodyBoldSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
