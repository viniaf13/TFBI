import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policies_section.dart';
import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_page.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/navigator_route_args.dart';

import '../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../utils/extensions/pump_with_router_extension.dart';
import 'tfb_router_test.dart';

void main() {
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(
      NavigatorRouteWithoutExtra(route: TfbAppRoutes.login),
    );
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets(
      'Tapping on a navigation tab tells the navigator to move to a new screen',
      (tester) async {
    // TfbRouter uses TfbBottomNavigationBar, it is simpler to pump the entire router than to mock the dependencies of TfbBottomNavigationBar
    await tester.pumpWithRouter(
      TfbRouter(
        initialLocation: TfbAppRoutes.dashboard.absolutePath,
        authenticatedProvidersBuilder: TestAuthenticatedProviders.new,
        unauthenticatedProvidersBuilder: TestUnauthenticatedProviders.new,
      ),
    );

    final policiesButtonWidget = find.byKey(const Key('policies_button'));
    await tester.tap(policiesButtonWidget);
    await tester.pumpAndSettle();

    expect(
      find.byType(PolicyListPage),
      findsOneWidget,
    );

    final homeButtonWidget = find.byType(ImageIcon);
    await tester.tap(homeButtonWidget.first);
    await tester.pump();

    expect(
      find.byType(Dashboard),
      findsOneWidget,
    );

    expect(
      find.byType(PoliciesSection),
      findsOneWidget,
    );

    expect(
      find.byType(ClaimsSection),
      findsOneWidget,
    );

    expect(
      find.byType(SupportSection),
      findsOneWidget,
    );
  });
}
