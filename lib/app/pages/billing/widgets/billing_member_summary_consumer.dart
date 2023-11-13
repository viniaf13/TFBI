import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/billing.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_item.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_padding.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class BillingMemberSummaryConsumer extends StatelessWidget {
  const BillingMemberSummaryConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final String memberShipPaymentUrl =
        context.getEnvironment<TfbEnvironment>().memberShipPaymentUrl;
    const loadingIndicator =
        SliverFillRemaining(child: Center(child: TfbBrandLoadingIcon()));

    return BlocConsumer<MemberSummaryCubit, MemberSummaryState>(
      listener: (context, state) {
        if (state is MemberSummaryFailure) {
          context.showErrorSnackBar(text: state.error.message);
        }
      },
      builder: (context, state) {
        if (state is MemberSummaryProcessing) {
          return loadingIndicator;
        }

        if (state is MemberSummarySuccess) {
          final List<PolicySummary> policies =
              state.memberSummary.supportedPolicies;
          return policies.isEmpty
              ? const SliverToBoxAdapter(child: BillingEmptyView())
              : SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kSpacingSmall),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: policies.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: kSpacingMedium,
                            ),
                            child: PolicyListItem(
                              policies[index],
                              TfbFilledButton.secondaryTextButton(
                                title:
                                    context.getLocalizationOf.billingDetailsCta,
                                onPressed: () => context.navigator
                                    .pushBillingDetailPage(policies[index]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: kSpacingSmall,
                            bottom: kSpacingMedium,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 311,
                              minHeight: 50,
                            ),
                            child: TfbFilledButton.primaryTextButton(
                              title: context
                                  .getLocalizationOf.makeAMembershipPayment,
                              onPressed: () {
                                TfbAnalytics.instance.track(
                                  MakeMembershipPaymentEvent(
                                    context.screenName,
                                  ),
                                );
                                context.navigator.pushToWebViewerPage(
                                  Uri.parse(memberShipPaymentUrl),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }

        if (state is MemberSummaryFailure) {
          return SliverToBoxAdapter(
            child: TextWithPadding(
              padding: const EdgeInsets.only(left: kSpacingLarge),
              textData: context.getLocalizationOf.loadingBillingError,
              style: context.tfbText.caption.copyWith(
                color: TfbBrandColors.redHigh,
              ),
            ),
          );
        }

        return loadingIndicator;
      },
    );
  }
}
