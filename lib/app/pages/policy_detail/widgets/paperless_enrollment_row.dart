import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class PaperlessEnrollmentRow extends StatelessWidget {
  const PaperlessEnrollmentRow({
    required this.policySummary,
    super.key,
    this.isEnabled = false,
  });

  final bool isEnabled;
  final PolicySummary policySummary;

  Widget _buildPaperlessEnrollmentContent({
    Widget textWidget = const SizedBox.shrink(),
  }) {
    return Builder(
      builder: (context) {
        final status = isEnabled
            ? context.getLocalizationOf.enabledLabel
            : context.getLocalizationOf.disabledLabel;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${context.getLocalizationOf.paperlessNotificationsLabel}:',
                    style: context.tfbText.bodyMediumSmall,
                    maxLines: 2,
                  ),
                ),
                Text(
                  status,
                  style: context.tfbText.bodyMediumLarge.copyWith(
                    color: isEnabled
                        ? TfbBrandColors.greenHighest
                        : TfbBrandColors.redHighest,
                  ),
                ),
              ],
            ),
            textWidget,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaperlessLookupCubit, PaperlessLookupState>(
      builder: (context, state) {
        if (!isEnabled) {
          return _buildPaperlessEnrollmentContent();
        }
        if (state is PaperlessLookupInitState) {
          context.read<PaperlessLookupCubit>().getPaperlessAccountDetails(
                policySummary,
              );
        }

        if (state is PaperlessLookupSuccessState) {
          return _buildPaperlessEnrollmentContent(
            textWidget: Text(
              '${context.getLocalizationOf.sendToLabel} '
              '${state.response.memberEmailAddress}',
              style: context.tfbText.bodyRegularSmall
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          );
        }
        if (state is PaperlessLookupFailureState) {
          return _buildPaperlessEnrollmentContent(
            textWidget: Text(
              context.getLocalizationOf.errorLoadingEmail,
              style: context.tfbText.bodyRegularLarge.copyWith(
                color: TfbBrandColors.redHigh,
              ),
            ),
          );
        }

        return const TfbBrandLoadingIcon(
          size: Size.fromHeight(kSpacingXxl),
        );
      },
    );
  }
}
