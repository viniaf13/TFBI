import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policies_section_multibloc_builder.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/policy_card_buttons.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_claims_label.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_section_counter.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_card_header.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/personal_auto_policy_vehicle_list.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/policy_card_address.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/policy_payment_label.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_page_view.dart';

part 'policy_card/policy_card.dart';

class PoliciesSection extends DashboardSection {
  const PoliciesSection({required this.sectionTitle, super.key})
      : super(
          title: sectionTitle,
          content: const PoliciesSectionBody(),
          trailing: const PolicySectionCounter(),
        );

  final String sectionTitle;
}

class PoliciesSectionBody extends StatelessWidget {
  const PoliciesSectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PoliciesSectionMultiBlocBuilder(
      shouldBuildAll:
          (memberPrevious, memberCurrent, claimsPrevious, claimsCurrent) {
        if (memberCurrent is MemberSummaryProcessing &&
            memberCurrent.isPullToRefresh) {
          return false;
        } else if (memberCurrent is MemberSummarySuccess &&
            memberPrevious is MemberSummaryProcessing &&
            memberPrevious.isPullToRefresh) {
          return false;
        } else if (claimsCurrent is ClaimsProcessingState &&
            claimsCurrent.isPullToRefresh) {
          return false;
        }
        return true;
      },
      builder: (memberSummaryState, claimsState) {
        if (memberSummaryState is MemberSummaryDetailsSuccess &&
            memberSummaryState.memberSummary.policies.isNotEmpty &&
            claimsState is! ClaimsProcessingState) {
          final policies = memberSummaryState.memberSummary.supportedPolicies;
          if (policies.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacingSmall),
              child: Row(
                children: [
                  Expanded(
                    child: DecoratedContainer(
                      child: Text(
                        context.getLocalizationOf
                            .youHaveNoAppSupportedPoliciesToDisplay,
                        style: context.tfbText.bodyRegularSmall.copyWith(
                          color: TfbBrandColors.blueHighest,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          final policyMap = memberSummaryState.policyMap;

          BlocProvider.of<PolicyScrollCubit>(context).scrollToPolicy(
            1,
            policies.length,
          );

          return BlocBuilder<PolicyScrollCubit, PolicyScrollState>(
            builder: (context, state) {
              return ExpandablePageView(
                padEnds: state is PolicyScrolled ? state.isScrolled : false,
                itemCount: policies.length,
                pageBuilder: (context, index) {
                  return PolicyCard(
                    policies[index],
                    policyMap[policies[index].policyNumber],
                  );
                },
                controller: PageController(
                  viewportFraction: policies.length == 1 ? .98 : .93,
                ),
                onPageChanged: (page) {
                  BlocProvider.of<PolicyScrollCubit>(context).scrollToPolicy(
                    page + 1,
                    policies.length,
                  );
                },
                borderRadius: context.radii.defaultRadiusBottom,
              );
            },
          );
        } else if (memberSummaryState is MemberSummaryFailure) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: kSpacingSmall,
              left: kSpacingSmall,
              right: kSpacingSmall,
            ),
            child: DecoratedFailureContainer(
              errorDescription: context.getLocalizationOf.containerErrorText(
                context.getLocalizationOf.policiesSectionTitle.toLowerCase(),
              ),
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.all(
            kSpacingSmall,
          ),
          child: DecoratedContainerWithLoading(containerHeight: 250),
        );
      },
    );
  }
}
