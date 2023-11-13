import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_state_consumer.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/claims_landing_page.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claims_header_view.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';

import '../../../domain/repositories/tfb_claims_client_repo_test.dart';
import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUp(
    () => when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial('')),
  );

  testWidgets('ClaimsLandingPage builds without error',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Provider<ClaimsBloc>(
        create: (_) => ClaimsBloc(
          claimsRepository:
              TfbClaimsClientRepository(client: MockClaimsClient()),
        ),
        child: TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: const ClaimsLandingPage(),
        ),
      ),
    );

    expect(find.byType(ClaimsLandingPage), findsOneWidget);
  });

  testWidgets('ClaimsLandingPage uses correct color for ColoredBox',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<ClaimsBloc>(
        create: (_) => ClaimsBloc(
          claimsRepository:
              TfbClaimsClientRepository(client: MockClaimsClient()),
        ),
        child: TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: const ClaimsLandingPage(),
        ),
      ),
    );

    final coloredBox =
        tester.firstWidget(find.byType(ColoredBox)) as ColoredBox;
    expect(coloredBox.color, TfbBrandColors.grayLowest);
  });

  testWidgets(
      'ClaimsLandingPage contains ClaimsHeaderView and ClaimsStateListener widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<ClaimsBloc>(
        create: (_) => ClaimsBloc(
          claimsRepository:
              TfbClaimsClientRepository(client: MockClaimsClient()),
        ),
        child: TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: const ClaimsLandingPage(),
        ),
      ),
    );

    expect(find.byType(ClaimsHeaderView), findsOneWidget);
    expect(find.byType(ClaimsStateConsumer), findsOneWidget);
  });
}
