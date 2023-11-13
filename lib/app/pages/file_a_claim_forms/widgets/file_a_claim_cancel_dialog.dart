import 'package:txfb_insurance_flutter/app/analytics/events/cancel_claim_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class CancelAClaimDialog extends StatelessWidget {
  const CancelAClaimDialog({
    required this.policy,
    super.key,
  });

  final PolicySelection policy;

  @override
  Widget build(BuildContext context) {
    return TfbBasicDialog(
      confirmActionTitle:
          context.getLocalizationOf.cancelButtonTitleOnCancelClaimDialog,
      confirmActionTitleColor: TfbBrandColors.redHighest,
      confirmButtonBackgroundColor: TfbBrandColors.redLow,
      cancelActionTitle:
          context.getLocalizationOf.continueButtonTitleOnCancelClaimDialog,
      title: context.getLocalizationOf.cancelHeaderOnCancelClaimDialog,
      subtitle: context.getLocalizationOf.cancelTitleOnCancelClaimDialog,
      onConfirm: () {
        TfbAnalytics.instance.track(
          CancelClaimEvent(
            policy.policyType.name(context),
            policy.policyNumber,
            policy.policyType == PolicyType.txPersonalAuto
                ? 'Auto claim form'
                : 'Property claim form',
          ),
        );
        context.showSuccessSnackBar(
          text: context.getLocalizationOf.snackBarCancelClaimSubmissionMessage,
          icon: Image.asset(TfbAssetStrings.checkCircleIcon),
          duration: const Duration(
            seconds: 5,
          ),
        );
        context.navigator.goToClaimsDetailsPage();
      },
      onCancel: () {
        Navigator.of(context).pop(false);
      },
    );
  }
}
