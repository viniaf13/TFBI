import 'dart:async';
import 'dart:io' show Platform;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/policy_scroll/policy_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/animation/animated_car_illustration.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/animation/background_illustration.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/animation/opacity_overlay.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/claims/claims_section_content.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policies_section.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/pull_to_refresh/pull_to_refresh_icon.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/quick_access/widgets/quick_access_insurance_card.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/quick_access/widgets/quick_access_roadside_assistance.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/support/customer_service_card_button.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/agent_card/agent_card.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';
import 'package:txfb_insurance_flutter/shared/widgets/permissions_widget.dart';

part 'claims/claims_section.dart';
part 'dashboard_header.dart';
part 'dashboard_section.dart';
part 'quick_access/quick_access_section.dart';
part 'support/support_section.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    required this.user,
    this.authenticatedNavigatorKey,
    super.key,
  });

  final TfbUser user;
  final GlobalKey<NavigatorState>? authenticatedNavigatorKey;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  OverlayEntry? opacityOverlay;
  AnimationController? controller;
  Timer? _translationAnimationDelayTimer;
  Timer? _opacityOverlayDelayTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final overlayContext = widget.authenticatedNavigatorKey?.currentContext;

      if (overlayContext == null) {
        return;
      }

      opacityOverlay = OverlayEntry(
        builder: (context) => const OpacityOverlay(),
      );

      Overlay.of(overlayContext).insert(opacityOverlay!);

      _opacityOverlayDelayTimer = Timer(
        OpacityOverlay.animationDuration,
        () => opacityOverlay?.remove(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final translationAnimation = createTranslationAnimation();
    final scrollController = PrimaryScrollController.of(context);
    final currentRelativePath = context.navigator.currentRelativePath;

    return BlocListener<StatusBarScrollCubit, StatusBarScrollState>(
      listener: (context, state) {
        if (state is StatusBarScrollActive &&
            state.pathOfScreenTapped == currentRelativePath) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          context
              .read<StatusBarScrollCubit>()
              .resetScrollNotification(currentRelativePath);
        }
      },
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TfbBrandColors.blueLowest,
                TfbBrandColors.blueHighest,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [.15, .15],
            ),
          ),
          child: AnimatedBuilder(
            animation: translationAnimation,
            builder: (context, _) {
              final offsetFromTop = translationAnimation.value *
                  MediaQuery.sizeOf(context).height /
                  1.6;

              final animationController = context.read<IndicatorController>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (_, __) {
                      return SizedBox(
                        height:
                            animationController.value * pullToRefreshIconHeight,
                      );
                    },
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          TfbBrandColors.blueLowest,
                          TfbBrandColors.blueHighest,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [.7, .7],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardHeader(
                          user: widget.user,
                        ),
                        _DashboardSpacer.firstItem(
                          child: Transform.translate(
                            offset: Offset(0, offsetFromTop),
                            child: QuickAccessSection(
                              sectionTitle:
                                  context.getLocalizationOf.quickAccess,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: offsetFromTop,
                  ),
                  _DashboardSpacer(
                    child: BlocProvider<PolicyScrollCubit>(
                      create: (context) => PolicyScrollCubit(),
                      child: PoliciesSection(
                        sectionTitle:
                            context.getLocalizationOf.policiesSectionTitle,
                      ),
                    ),
                  ),
                  _DashboardSpacer(
                    child: ClaimsSection(
                      sectionTitle:
                          context.getLocalizationOf.claimsSectionTitle,
                    ),
                  ),
                  const SupportSection(),
                  if (Platform.isIOS)
                    const PermissionsWidget(
                      AppPermission.appTrackingTransparency,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Animation<double> createTranslationAnimation() {
    controller?.dispose();
    _translationAnimationDelayTimer?.cancel();
    _opacityOverlayDelayTimer?.cancel();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    final translationAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: controller!, curve: Curves.easeOutCubic));

    Future<void> startAnimationAfterScreenTransitionDelay() async {
      _translationAnimationDelayTimer =
          Timer(getDefaultPageTransitionDuration(), controller!.forward);
    }

    startAnimationAfterScreenTransitionDelay();

    return translationAnimation;
  }

  @override
  void dispose() {
    controller?.dispose();
    _translationAnimationDelayTimer?.cancel();
    _opacityOverlayDelayTimer?.cancel();
    super.dispose();
  }
}

class _DashboardSpacer extends StatelessWidget {
  const _DashboardSpacer({
    required this.child,
    super.key,
    this.spacer = 18,
  });

  factory _DashboardSpacer.firstItem({required Widget child, Key? key}) {
    final isAnimatingCar = ValueNotifier(false);
    final isBackgroundImageLoaded = ValueNotifier(false);
    final backgroundImageSize = ValueNotifier(Size.zero);

    final backgroundImage = Image.asset(
      TfbAssetStrings.dashboardCarBackground,
      fit: BoxFit.fill,
    );

    return _DashboardSpacer(
      key: key,
      spacer: 0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  BackgroundIllustration(
                    key: GlobalKey(),
                    isImageLoaded: isBackgroundImageLoaded,
                    backgroundImage: backgroundImage,
                    backgroundImageSize: backgroundImageSize,
                  ),
                  AnimatedCarIllustration(
                    isAnimating: isAnimatingCar,
                    backgroundImageSize: backgroundImageSize,
                  ),
                ],
              ),
              const SizedOverflowBox(
                size: Size.fromHeight(
                  kSpacingXxl,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingExtraSmall),
            child: child,
          ),
        ],
      ),
    );
  }

  final Widget child;
  final double spacer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: spacer),
      child: child,
    );
  }
}
