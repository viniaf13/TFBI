import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/wallet/wallet_card_ios.dart';
import 'package:plugin_haven/wallet/wallet_card_platform_interface.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_builder.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_content.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

import '../../../../mocks/bloc/mock_wallet_cubit.dart';
import '../../../../mocks/mock_auto_policy.dart';
import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../mocks/mock_save_auto_id_card.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockAutoPolicyCubit autoPolicyCubit;

  final mockPolicy = MockPolicy.createPolicySummary();

  setUp(() {
    autoPolicyCubit = MockAutoPolicyCubit();
  });

  testWidgets('renders TfbBrandLoadingIcon when AutoPolicyProcessing',
      (WidgetTester tester) async {
    when(() => autoPolicyCubit.state).thenReturn(AutoPolicyProcessing());

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: BlocProvider<AutoPolicyCubit>.value(
            value: autoPolicyCubit,
            child: InsuranceCardBuilder(policy: mockPolicy),
          ),
        ),
      ),
    );

    expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);
  });

  testWidgets(
      'renders error message when state is not AutoPolicyProcessing or '
      'AutoPolicySuccess', (WidgetTester tester) async {
    when(() => autoPolicyCubit.state).thenReturn(
      AutoPolicyFailure(
        error: TfbRequestError(),
      ),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: BlocProvider<AutoPolicyCubit>.value(
            value: autoPolicyCubit,
            child: InsuranceCardBuilder(
              policy: mockPolicy,
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().insuranceCardLoadError),
      findsOneWidget,
    );
  });

  group(
      'Tests to verify the behavior of the InsuranceCardContent during state updates',
      () {
    late MockWalletCubit mockWalletCubit;
    late MockSaveAutoIdCardCubit mockSaveAutoIdCardCubit;
    late TfbAutoPolicyDocumentMetadata mockTfbAutoPolicy;

    setUp(() {
      mockWalletCubit = MockWalletCubit();
      mockSaveAutoIdCardCubit = MockSaveAutoIdCardCubit();
      mockTfbAutoPolicy = TfbAutoPolicyDocumentMetadata(
        policyNumber: '12345',
        vehicleDisplayTitles: ['2022 Uno mile'],
        expirationDate: DateTime.now(),
        documentPath: '/',
        id: 'id',
      );
      when(
        () => mockWalletCubit.state,
      ).thenReturn(const WalletSuccess());
      when(
        () => mockSaveAutoIdCardCubit.state,
      ).thenReturn(
        SaveAutoIdCardSuccess(idCardMetadata: mockTfbAutoPolicy),
      );
      when(() => mockSaveAutoIdCardCubit.getIsIdCardSaved(mockPolicy))
          .thenAnswer((_) => Future.value());
      WalletCardPlatform.instance = IosWalletCard();
    });
    testWidgets(
        'Test to verify if the InsuranceCardContent remains loaded after a success case',
        (tester) async {
      final listStates = [
        AutoPolicySuccess(autoPolicyDetail: MockAutoPolicyDetail()),
        AutoPolicyInitial(),
      ];
      whenListen(
        autoPolicyCubit,
        Stream.fromIterable(
          listStates,
        ),
        initialState: AutoPolicyInitial(),
      );
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<AutoPolicyCubit>.value(
                  value: autoPolicyCubit,
                ),
                BlocProvider<WalletCubit>.value(
                  value: mockWalletCubit,
                ),
                BlocProvider<SaveAutoIdCardCubit>.value(
                  value: mockSaveAutoIdCardCubit,
                ),
              ],
              child: SizedBox(
                height: 300,
                child: InsuranceCardBuilder(
                  policy: mockPolicy,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(InsuranceCardContent), findsOneWidget);
    });

    testWidgets('Test to verify if changes occur in the other AutoPolicyState',
        (tester) async {
      final listStates = [
        AutoPolicyFailure(error: TfbRequestError(message: 'Mock Message')),
        AutoPolicyInitial(),
      ];
      whenListen(
        autoPolicyCubit,
        Stream.fromIterable(
          listStates,
        ),
        initialState: AutoPolicyInitial(),
      );
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<AutoPolicyCubit>.value(
                  value: autoPolicyCubit,
                ),
                BlocProvider<WalletCubit>.value(
                  value: mockWalletCubit,
                ),
                BlocProvider<SaveAutoIdCardCubit>.value(
                  value: mockSaveAutoIdCardCubit,
                ),
              ],
              child: SizedBox(
                height: 300,
                child: InsuranceCardBuilder(
                  policy: mockPolicy,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(DecoratedContainerWithLoading), findsOneWidget);
    });
  });
}
