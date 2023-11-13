import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/ag_advantage_property_detail/ag_advantage_policy_detail_property.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/billing_card/billing_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/homeowners_property_detail/homeowners_policy_detail_property.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_builder.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_claims_card/policy_detail_claims_card.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_widgets.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/policy_documents_builder.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/vehicles_detail/policy_detail_vehicles.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/agent_card/agent_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

// Parent container for all Policy Detail pages.
// Specific elements are built based on policy type.
class PolicyDetailPage extends StatelessWidget with PagePropertiesMixin {
  const PolicyDetailPage(this.policy, {super.key});

  @override
  String get screenName => 'Policy screen';

  final PolicySummary policy;

  // Each list item is contained in a PolicyCardDetail
  // - PolicyOverview
  // - InsuranceCard
  // - PolicyHolder
  // - If Auto
  //   - Drivers
  //   - Vehicles
  // - Coverages
  // - Billing
  // - PolicyDocuments
  // - Claims
  // - Agent
  @override
  Widget build(BuildContext context) {
    context.read<AgentCubit>().getAgent(context.getUserMemberNumber);

    if (policy.policyType == PolicyType.txPersonalAuto) {
      context.read<AutoPolicyCubit>().getPersonalAutoPolicy(policy);
    }

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          showBackButton: true,
          titleString: policy.policyType.name(context),
        ),
        body: TfbDropShadowScrollWidget(
          child: BlocConsumer<MemberSummaryCubit, MemberSummaryState>(
            listener: (context, state) {
              if (state is MemberSummaryFailure) {
                context.showErrorSnackBar(
                  text: context.getLocalizationOf.somethingWentWrong,
                );
              }

              if (state is MemberSummaryDetailsSuccess) {
                final details = state.policyMap[policy.policyNumber];
                if (details == null || state.error != null) {
                  context.showErrorSnackBar(
                    text: context.getLocalizationOf.somethingWentWrong,
                  );
                }
              }
            },
            builder: (context, memberSummaryState) {
              if (memberSummaryState is MemberSummaryFailure) {
                return Container();
              } else if (memberSummaryState is MemberSummaryDetailsSuccess) {
                return BlocBuilder<AgentCubit, AgentState>(
                  builder: (context, agentState) {
                    final details =
                        memberSummaryState.policyMap[policy.policyNumber];

                    if (details == null) {
                      return Padding(
                        padding: const EdgeInsets.all(kSpacingSmall),
                        child: Text(
                          context.getLocalizationOf.policyOverviewError,
                          style: context.tfbText.caption
                              .copyWith(color: TfbBrandColors.redHigh),
                        ),
                      );
                    }

                    final items = <StatelessWidget>[
                      PolicyDetailCard(
                        child: PolicyDetailOverview.policy(policy, details),
                      ),
                      if (details is AutoPolicyDetail)
                        PolicyDetailCard(
                          child: InsuranceCardBuilder(policy: policy),
                        ),
                      PolicyDetailCard(
                        child: PolicyDetailPolicyHolder(
                          detail: details,
                        ),
                      ),
                      if (details is HomeownerPolicyDetail)
                        PolicyDetailCard(
                          padding: EdgeInsets.zero,
                          child:
                              HomeownersPolicyDetailProperty(details: details),
                        ),
                      if (details is AgAdvantagePolicyDetail)
                        PolicyDetailCard(
                          padding: EdgeInsets.zero,
                          child: AgAdvantagePolicyDetailProperty(
                            details: details,
                          ),
                        ),
                      if (details is AutoPolicyDetail) ...[
                        PolicyDetailCard(
                          child: PolicyDetailDrivers(details: details),
                        ),
                        PolicyDetailCard(
                          padding: EdgeInsets.zero,
                          child: PolicyDetailVehicles(
                            details: details,
                          ),
                        ),
                      ],
                      PolicyDetailCard(
                        padding: EdgeInsets.zero,
                        child: BillingCard(
                          policySummary: policy,
                          policyBilling: details.policyBilling,
                        ),
                      ),
                      if (details is AutoPolicyDetail)
                        PolicyDetailCard(
                          padding: EdgeInsets.zero,
                          child: PolicyDocumentsBuilder(policy: policy),
                        ),
                      const PolicyDetailClaimsCard(),
                      if (agentState is AgentDetailsSuccess) const AgentCard(),
                    ];

                    return _showPolicyDetailCardsList(items);
                  },
                );
              }

              return const Center(
                child: TfbBrandLoadingIcon(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _showPolicyDetailCardsList(
    List<StatelessWidget> items,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: kSpacingMedium),
              child: items[index],
            );
          },
        ),
      ),
    );
  }
}
