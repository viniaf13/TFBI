import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/insurance_card_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_content.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/wallet_button.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../mocks/bloc/mock_wallet_cubit.dart';
import '../../../../mocks/mock_auto_policy.dart';
import '../../../../mocks/mock_save_auto_id_card.dart';
import '../../../../mocks/models/mock_policy_metadata.dart';
import '../../../../mocks/page_parameters/mock_pdf_viewer_events_parameters.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import '../../../analytics/mock_analytics_provider.dart';

void main() {
  late MockSaveAutoIdCardCubit autoPolicyCubit;
  late MockWalletCubit walletCubit;
  final PolicySummary mockPolicySummary = MockPolicySummary();
  final AutoPolicyDetail mockSixMonthAutoPolicy = MockAutoPolicyDetail();

  final TfbAutoPolicyDocumentMetadata mockTfbAutoPolicy =
      MockPolicyMetadata.getDocumentMetadata();

  late MockAnalyticsProvider mockAnalyticsProvider;

  setUpAll(() {
    mockAnalyticsProvider = MockAnalyticsProvider();
    TfbAnalytics.instance.add(mockAnalyticsProvider);
    TfbAnalytics.instance.init(const TfbAnalyticsConfig());

    mocktail.registerFallbackValue(FakeSaveAutoIdCardState());

    final pdfViewerEventsParameters =
        MockPdfViewerEventsParameters.getEventsParameters();
    registerFallbackValue(
      PdfViewerPageParameters(
        title: 'title',
        filePath: 'filePath',
        pdfViewerEventsParameters: pdfViewerEventsParameters,
      ),
    );
  });

  setUp(() {
    autoPolicyCubit = MockSaveAutoIdCardCubit();
    walletCubit = MockWalletCubit();
    mocktail.when(() => walletCubit.state).thenReturn(WalletInitial());

    mocktail
        .when(() => autoPolicyCubit.getIsIdCardSaved(mockPolicySummary))
        .thenAnswer((_) => Future.value());
    mocktail
        .when(
          () => autoPolicyCubit.downloadAndSaveAutoIdCard(
            mockPolicySummary,
            mockSixMonthAutoPolicy,
            isTemporary: false,
          ),
        )
        .thenAnswer((_) => Future.value());
  });

  testWidgets(
    'Insurance card should be rendered with header, buttons and switch correctly.',
    (WidgetTester tester) async {
      mocktail.when(() => autoPolicyCubit.state).thenReturn(
            const SaveAutoIdCardInitial(),
          );

      // Override the default instance which is set according to platform,
      // which is not available for testing purposes.
      WalletCardPlatform.instance = IosWalletCard();

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<SaveAutoIdCardCubit>.value(
                  value: autoPolicyCubit,
                ),
                BlocProvider<WalletCubit>.value(
                  value: walletCubit,
                ),
              ],
              child: InsuranceCardContent(
                policySummary: mockPolicySummary,
                policyDetails: mockSixMonthAutoPolicy,
              ),
            ),
          ),
        ),
      );

      expect(
        find.text(AppLocalizationsEn().insuranceCardTitle),
        findsOneWidget,
      );
      expect(find.byType(WalletButton), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);
    },
  );

  testWidgets(
    'Insurance card should be rendered with switch element set to false',
    (WidgetTester tester) async {
      mocktail.when(() => autoPolicyCubit.state).thenReturn(
            const SaveAutoIdCardInitial(),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<SaveAutoIdCardCubit>.value(
                  value: autoPolicyCubit,
                ),
                BlocProvider<WalletCubit>.value(
                  value: walletCubit,
                ),
              ],
              child: InsuranceCardContent(
                policySummary: mockPolicySummary,
                policyDetails: mockSixMonthAutoPolicy,
              ),
            ),
          ),
        ),
      );

      final foundSwitch = find.byType(SwitchListTile);
      final SwitchListTile switchWidget = tester.widget(foundSwitch);
      expect(switchWidget.value, false);
    },
  );

  testWidgets(
    'Insurance card switch should be active when tapped',
    (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      mocktail.when(() => autoPolicyCubit.state).thenReturn(
            SaveAutoIdCardSuccess(
              idCardMetadata: mockTfbAutoPolicy,
              showSnackbar: true,
            ),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<SaveAutoIdCardCubit>.value(
                  value: autoPolicyCubit,
                ),
                BlocProvider<WalletCubit>.value(
                  value: walletCubit,
                ),
              ],
              child: InsuranceCardContent(
                policySummary: mockPolicySummary,
                policyDetails: mockSixMonthAutoPolicy,
              ),
            ),
          ),
        ),
      );

      final switchWidget = find.byType(SwitchListTile);
      final SwitchListTile switchButton = tester.widget(switchWidget);

      expect(switchWidget, findsOneWidget);
      expect(switchButton.value, true);

      debugDefaultTargetPlatformOverride = null;
    },
  );

  testWidgets('Test TfbAnalytics track ViewIdCardEvent',
      (WidgetTester tester) async {
    mocktail.when(() => autoPolicyCubit.state).thenReturn(
          SaveAutoIdCardSuccess(
            idCardMetadata: mockTfbAutoPolicy,
            showSnackbar: true,
          ),
        );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<SaveAutoIdCardCubit>.value(
                value: autoPolicyCubit,
              ),
              BlocProvider<WalletCubit>.value(
                value: walletCubit,
              ),
            ],
            child: InsuranceCardContent(
              policySummary: mockPolicySummary,
              policyDetails: mockSixMonthAutoPolicy,
            ),
          ),
        ),
      ),
    );

    final button = find.text(AppLocalizationsEn().insuranceCardViewCta);

    await tester.tap(button);
    await tester.pump();

    final event =
        mockAnalyticsProvider.loggedEvents.whereType<ViewIdCardEvent>().first;

    expect(event.name, kViewIdCardEvent);
  });
}

class MockBuildContext extends mocktail.Mock implements BuildContext {}

class MockPolicySummary extends mocktail.Mock implements PolicySummary {}
