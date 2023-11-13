import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_content.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/separator_line.dart';

class InsuranceCardBuilder extends StatelessWidget {
  const InsuranceCardBuilder({
    required this.policy,
    super.key,
  });

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoPolicyCubit, AutoPolicyState>(
      buildWhen: (previous, current) => previous is! AutoPolicySuccess,
      builder: (context, autoPolicyState) {
        if (autoPolicyState is AutoPolicyProcessing ||
            autoPolicyState is AutoPolicyInitial) {
          return const DecoratedContainerWithLoading(
            containerHeight: 80,
          );
        } else if (autoPolicyState is AutoPolicySuccess) {
          return InsuranceCardContent(
            policySummary: policy,
            policyDetails: autoPolicyState.autoPolicyDetail,
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.getLocalizationOf.insuranceCardTitle,
                style: context.tfbText.header3.copyWith(
                  color: TfbBrandColors.blueHighest,
                ),
              ),
              const SeparatorLine(),
              Text(
                context.getLocalizationOf.insuranceCardLoadError,
                style: context.tfbText.bodyRegularSmall.copyWith(
                  color: TfbBrandColors.redHigh,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
