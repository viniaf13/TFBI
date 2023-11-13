import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_state_consumer.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_header_view.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/utils/tab_tap_notifier.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class ClaimsLandingPage extends StatelessWidget {
  const ClaimsLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = PrimaryScrollController.of(context);

    final tabTapNotifier = context.read<TabTapNotifier>();
    tabTapNotifier.addListener(() {
      if (tabTapNotifier.value == TfbAppRoutes.claims) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          titleString: context.getLocalizationOf.claimsTitle,
        ),
        body: SafeArea(
          child: ColoredBox(
            color: TfbBrandColors.grayLowest,
            child: Padding(
              padding: const EdgeInsets.only(
                left: kSpacingSmall,
                right: kSpacingSmall,
              ),
              child: TfbDropShadowScrollWidget(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: const Column(
                    children: [
                      ClaimsHeaderView(),
                      ClaimsStateConsumer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// It consists of:
// - ClaimsHeaderView (done)
// - ClaimsEmptyStateView (done)
// - ClaimsListView
//  - ClaimsSectionHeaderView
//  - ClaimView
//    - ClaimHeaderView
//    - ClaimControllerView (the triangle up/down)
//    - ClaimDetailView
//      - ClaimInformationView
//      - ClaimPhotoView
//        - PhotoCarouselView
//      - ClaimFooterView
