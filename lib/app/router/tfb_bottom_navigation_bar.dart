import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/utils/tab_tap_notifier.dart';
import 'package:txfb_insurance_flutter/shared/widgets/no_splash_theme_provider.dart';

final _locationMap = {
  0: TfbAppRoutes.dashboard,
  1: TfbAppRoutes.policies,
  2: TfbAppRoutes.billing,
  3: TfbAppRoutes.claims,
  4: TfbAppRoutes.account,
};

class TfbBottomNavigationBar extends StatelessWidget {
  const TfbBottomNavigationBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> tabsWithoutLabels = [
      BottomNavigationBarItem(
        icon: const PaddedImageIcon(
          ImageIcon(
            AssetImage(TfbAssetStrings.homeIcon),
          ),
        ),
        label: context.getLocalizationOf.bottomBarTitleHome,
      ),
      BottomNavigationBarItem(
        icon: const PaddedImageIcon(
          ImageIcon(
            key: Key('policies_button'),
            AssetImage(TfbAssetStrings.policiesIcon),
          ),
        ),
        label: context.getLocalizationOf.bottomBarTitlePolicies,
      ),
      BottomNavigationBarItem(
        icon: const PaddedImageIcon(
          ImageIcon(
            AssetImage(TfbAssetStrings.billingIcon),
          ),
        ),
        label: context.getLocalizationOf.bottomBarTitleBilling,
      ),
      BottomNavigationBarItem(
        icon: const PaddedImageIcon(
          ImageIcon(
            AssetImage(TfbAssetStrings.claimsIcon),
          ),
        ),
        label: context.getLocalizationOf.bottomBarTitleClaims,
      ),
      BottomNavigationBarItem(
        icon: const PaddedImageIcon(
          ImageIcon(
            AssetImage(TfbAssetStrings.accountIcon),
          ),
        ),
        label: context.getLocalizationOf.bottomBarTitleAccount,
      ),
    ];
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: NoSplashThemeProvider(
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    color: Colors.black.withAlpha(38),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: navigationShell.currentIndex,
                items: tabsWithoutLabels,
                onTap: (index) => onTapNavigationBarItem(index, context),
                selectedFontSize: 12,
                selectedIconTheme:
                    const IconThemeData(color: TfbBrandColors.blueHigh),
                unselectedItemColor: TfbBrandColors.grayHigh,
                selectedLabelStyle: context.tfbText.caption.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 2,
                  color: TfbBrandColors.blueHighest,
                ),
              ),
            ),
          ),
          body: navigationShell,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).padding.top,
          child: GestureDetector(
            excludeFromSemantics: true,
            onTap: () {
              context.read<StatusBarScrollCubit>().emitScrollNotification(
                    context.navigator.currentRelativePath,
                  );
            },
          ),
        ),
      ],
    );
  }

  void onTapNavigationBarItem(int index, BuildContext context) {
    final previousLocation = context.navigator.location;

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );

    final currentLocation = context.navigator.location;

    final didTapTabAlreadyDisplayed = previousLocation == currentLocation;

    if (didTapTabAlreadyDisplayed) {
      context.read<TabTapNotifier>().update(_locationMap[index]);
    }
  }
}

class PaddedImageIcon extends StatelessWidget {
  const PaddedImageIcon(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSpacingExtraSmall),
      child: child,
    );
  }
}
