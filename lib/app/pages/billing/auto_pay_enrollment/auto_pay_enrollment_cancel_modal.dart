import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_basic_dialog.dart';

class AutoPayEnrollmentCancelModal extends StatelessWidget {
  const AutoPayEnrollmentCancelModal({
    required this.policy,
    this.onConfirm,
    super.key,
  });

  final VoidCallback? onConfirm;
  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    final String autopaySubtitle = policy.isAutoPayEnabled
        ? context.getLocalizationOf.autoPayManageCancelModalSubTitle
        : context.getLocalizationOf.autoPayEnrollCancelModalSubTitle;
    return TfbBasicDialog(
      confirmActionTitle:
          context.getLocalizationOf.autoPayEnrollCancelModalConfirmCta,
      cancelActionTitle:
          context.getLocalizationOf.autoPayEnrollCancelModalBackCta,
      title: context.getLocalizationOf.autoPayEnrollCancelModalTitle,
      subtitle: autopaySubtitle,
      confirmActionTitleColor: TfbBrandColors.redHighest,
      confirmButtonBackgroundColor: TfbBrandColors.redLow,
      onConfirm: () {
        Navigator.pop(context, true);
        onConfirm?.call();
      },
      onCancel: () {
        Navigator.pop(context, false);
      },
    );
  }
}
