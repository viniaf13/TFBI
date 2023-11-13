import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/pull_to_refresh/pull_to_refresh_container.dart';
import 'package:txfb_insurance_flutter/shared/widgets/has_scrolled_listener.dart';

class DashboardScreen extends StatelessWidget with PagePropertiesMixin {
  const DashboardScreen({
    required this.user,
    this.authenticatedNavigatorKey,
    super.key,
  });

  final TfbUser user;
  final GlobalKey<NavigatorState>? authenticatedNavigatorKey;

  @override
  String get screenName => 'Dashboard screen';

  @override
  Widget build(BuildContext context) {
    TfbAnalytics.instance.track(const DashboardScreenViewEvent());
    return ScaffoldMessenger(
      child: DashboardScaffold(
        body: Dashboard(
          user: user,
          authenticatedNavigatorKey: authenticatedNavigatorKey,
        ),
      ),
    );
  }
}

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> hasScrolledNotifier = ValueNotifier(false);

    return HasScrolledListener(
      valueNotifier: hasScrolledNotifier,
      child: ValueListenableBuilder(
        valueListenable: hasScrolledNotifier,
        builder: (_, hasScrolled, __) {
          return Scaffold(
            backgroundColor: hasScrolled
                ? TfbBrandColors.blueHighest
                : TfbBrandColors.blueLowest,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: AppBar(
                backgroundColor: TfbBrandColors.blueLowest,
                shadowColor: TfbBrandColors.black,
              ),
            ),
            body: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    TfbBrandColors.blueLowest,
                    TfbBrandColors.blueHighest,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [.5, .5],
                ),
              ),
              child: PullToRefreshContainer(
                child: body,
              ),
            ),
          );
        },
      ),
    );
  }
}
