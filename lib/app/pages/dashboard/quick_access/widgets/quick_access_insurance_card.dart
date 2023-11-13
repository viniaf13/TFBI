import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/quick_access/widgets/quick_access_card.dart';
import 'package:txfb_insurance_flutter/app/pages/insurance_card/insurance_card_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';

class QuickAccessInsuranceCard extends StatelessWidget {
  const QuickAccessInsuranceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberSummaryCubit, MemberSummaryState>(
      buildWhen: (previous, current) {
        if (current is MemberSummaryProcessing && current.isPullToRefresh) {
          return false;
        } else if (current is MemberSummarySuccess &&
            previous is MemberSummaryProcessing &&
            previous.isPullToRefresh) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is MemberSummaryFailure) {
          return const SizedBox.shrink();
        } else if (state is MemberSummaryInitial ||
            state is MemberSummaryProcessing ||
            state is! MemberSummaryDetailsSuccess) {
          return const Expanded(
            child: DecoratedContainerWithLoading(
              containerHeight: 50,
              containerColor: TfbBrandColors.blueLowest,
            ),
          );
        } else if (state.memberSummary.personalAutoPolicies.isNotEmpty) {
          if (state.memberSummary.personalAutoPolicies.length > 1) {
            return Expanded(
              child: QuickAccessCard(
                title: context.getLocalizationOf.viewIdCard,
                onTapped: () {
                  TfbAnalytics.instance.track(
                    ViewIdCardEvent(context.screenName),
                  );
                  context.navigator.goToPolicyListPage();
                },
              ),
            );
          }

          /// When there only one policy, the CTA should open the insurance card
          /// of the given policy
          return Expanded(
            child: QuickAccessCard(
              title: context.getLocalizationOf.viewIdCard,
              onTapped: () {
                TfbAnalytics.instance.track(
                  ViewIdCardEvent(context.screenName),
                );
                final policySummary =
                    state.memberSummary.personalAutoPolicies[0];
                context.navigator.pushInsuranceCardPage(
                  params: InsuranceCardPageParameters(
                    policySummary: policySummary,
                    pdfViewerEventsParameters: PdfViewerEventsParameters(
                      screenName: context.screenName,
                      cta: DocumentEventViewOptions.viewInsuranceCard.value,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Expanded(
            child: QuickAccessCard(
              title: context.getLocalizationOf.claimsFileAClaimCTA,
              onTapped: () {
                context.navigator.pushFileAClaimPage();
              },
            ),
          );
        }
      },
    );
  }
}
