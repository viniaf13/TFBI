import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_item.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class PolicyListBuilder extends StatelessWidget {
  const PolicyListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MemberSummaryCubit, MemberSummaryState>(
      buildWhen: (previous, current) => current is! MemberSummaryDetailsSuccess,
      listener: (context, state) {
        if (state is MemberSummaryDetailsSuccess && state.error != null) {
          context.showErrorSnackBar(
            text: state.error!.message,
          );
        } else if (state is MemberSummaryFailure) {
          context.showErrorSnackBar(
            text: state.error.message,
          );
        }
      },
      builder: (context, state) {
        if (state is MemberSummarySuccess) {
          final policies = state.memberSummary.supportedPolicies;
          if (policies.isNotEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingSmall,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: policies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: kSpacingMedium),
                    child: PolicyListItem(
                      policies[index],
                      TfbFilledButton.secondaryTextButton(
                        title: context.getLocalizationOf.policyOverviewCta,
                        onPressed: () {
                          context.navigator
                              .pushPolicyDetailPage(policies[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacingLarge,
                ),
                child: Text(
                  context.getLocalizationOf.emptyPolicyList,
                  style: context.tfbText.bodyMediumSmall
                      .copyWith(color: TfbBrandColors.blueHighest),
                ),
              ),
            );
          }
        } else if (state is MemberSummaryFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacingLarge,
              ),
              child: Text(
                context.getLocalizationOf.errorPolicyList,
                style: context.tfbText.caption
                    .copyWith(color: TfbBrandColors.redHigh),
              ),
            ),
          );
        }
        return const SliverFillRemaining(
          child: Center(
            child: TfbBrandLoadingIcon(),
          ),
        );
      },
    );
  }
}
