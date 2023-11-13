import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/save_insurance_card_switch.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../mocks/mock_auto_policy.dart';
import '../../../../mocks/mock_save_auto_id_card.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import 'insurance_card_content_test.dart';

void main() {
  late SaveAutoIdCardCubit saveAutoIdCardCubit;
  late PolicySummary mockPolicy;
  late AutoPolicyDetail mockPolicyDetails;
  final TfbAutoPolicyDocumentMetadata mockTfbAutoPolicy =
      TfbAutoPolicyDocumentMetadata(
    policyNumber: '12345',
    vehicleDisplayTitles: ['2022 Uno mile'],
    expirationDate: DateTime.now(),
    documentPath: '/',
    id: 'id',
  );

  setUp(
    () {
      mockPolicy = MockPolicySummary();
      mockPolicyDetails = MockAutoPolicyDetail();
      saveAutoIdCardCubit = MockSaveAutoIdCardCubit();

      mocktail
          .when(() => saveAutoIdCardCubit.getIsIdCardSaved(mockPolicy))
          .thenAnswer((_) => Future.value());

      mocktail
          .when(
            () => saveAutoIdCardCubit.downloadAndSaveAutoIdCard(
              mockPolicy,
              mockPolicyDetails,
              isTemporary: true,
            ),
          )
          .thenAnswer((_) => Future.value());

      mocktail
          .when(
            () => saveAutoIdCardCubit.removeSavedAutoIdCard(
              mockTfbAutoPolicy,
            ),
          )
          .thenAnswer((_) => Future.value());
    },
  );

  testWidgets(
    'SaveInsuranceCardSwitch should call removeSavedAutoIdCard method '
    'when tap if switch is enabled',
    (tester) async {
      mocktail.when(() => saveAutoIdCardCubit.state).thenReturn(
            SaveAutoIdCardSuccess(
              idCardMetadata: mockTfbAutoPolicy,
              showSnackbar: true,
            ),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<SaveAutoIdCardCubit>.value(
              value: saveAutoIdCardCubit,
              child: SaveInsuranceCardSwitch(
                policySummary: mockPolicy,
                policyDetails: mockPolicyDetails,
              ),
            ),
          ),
        ),
      );

      await tester.pump(
        const Duration(milliseconds: 200),
      );

      final foundSwitch = find.byType(SwitchListTile);
      final SwitchListTile switchWidget = tester.widget(foundSwitch);

      await tester.tap(foundSwitch);
      await tester.pumpAndSettle();

      expect(foundSwitch, findsOneWidget);
      expect(switchWidget.value, true);
      mocktail
          .verify(
            () => saveAutoIdCardCubit.removeSavedAutoIdCard(
              mockTfbAutoPolicy,
            ),
          )
          .called(1);
    },
  );

  testWidgets(
    'SaveInsuranceCardSwitch display loading snackBar when state of '
    'SaveAutoCardId is SaveAutoCardIdProcessing',
    (tester) async {
      mocktail.when(() => saveAutoIdCardCubit.state).thenReturn(
            const SaveAutoIdCardProcessing(showSnackbar: true),
          );

      final expectedStates = [
        const SaveAutoIdCardProcessing(showSnackbar: true),
      ];

      whenListen(saveAutoIdCardCubit, Stream.fromIterable(expectedStates));

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<SaveAutoIdCardCubit>.value(
              value: saveAutoIdCardCubit,
              child: SaveInsuranceCardSwitch(
                policySummary: mockPolicy,
                policyDetails: mockPolicyDetails,
              ),
            ),
          ),
        ),
      );

      await tester.pump(
        const Duration(milliseconds: 200),
      );

      final foundSwitch = find.byType(SwitchListTile);
      final SwitchListTile switchWidget = tester.widget(foundSwitch);

      expect(foundSwitch, findsOneWidget);
      expect(switchWidget.value, false);

      final foundSnackbar = find.byType(TfbSnackbarContent);
      expect(foundSnackbar, findsOneWidget);

      final foundSnackbarText =
          find.text(AppLocalizationsEn().insuranceCardSaveProcessing);
      expect(foundSnackbarText, findsOneWidget);
    },
  );

  testWidgets(
    'SaveInsuranceCardSwitch display success snackBar when state of '
    'SaveAutoCardId is SaveAutoIdCardSuccess',
    (tester) async {
      mocktail.when(() => saveAutoIdCardCubit.state).thenReturn(
            SaveAutoIdCardSuccess(
              idCardMetadata: mockTfbAutoPolicy,
              showSnackbar: true,
            ),
          );

      final expectedStates = [
        SaveAutoIdCardSuccess(
          idCardMetadata: mockTfbAutoPolicy,
          showSnackbar: true,
        ),
      ];

      whenListen(saveAutoIdCardCubit, Stream.fromIterable(expectedStates));

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<SaveAutoIdCardCubit>.value(
              value: saveAutoIdCardCubit,
              child: SaveInsuranceCardSwitch(
                policySummary: mockPolicy,
                policyDetails: mockPolicyDetails,
              ),
            ),
          ),
        ),
      );

      await tester.pump(
        const Duration(milliseconds: 200),
      );

      final foundSwitch = find.byType(SwitchListTile);
      final SwitchListTile switchWidget = tester.widget(foundSwitch);

      expect(foundSwitch, findsOneWidget);
      expect(switchWidget.value, true);

      final foundSnackbar = find.byType(TfbSnackbarContent);
      expect(foundSnackbar, findsOneWidget);

      final foundSnackbarText = find.text('Insurance card saved!');
      expect(foundSnackbarText, findsOneWidget);
    },
  );

  testWidgets(
    'SaveInsuranceCardSwitch display error snackBar when state of '
    'SaveAutoCardId is SaveAutoIdCardFailure',
    (tester) async {
      mocktail.when(() => saveAutoIdCardCubit.state).thenReturn(
            SaveAutoIdCardFailure(
              error: Exception('Failure Mock'),
            ),
          );

      final expectedStates = [
        SaveAutoIdCardFailure(
          error: Exception('Failure Mock'),
        ),
      ];

      whenListen(saveAutoIdCardCubit, Stream.fromIterable(expectedStates));

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<SaveAutoIdCardCubit>.value(
              value: saveAutoIdCardCubit,
              child: SaveInsuranceCardSwitch(
                policySummary: mockPolicy,
                policyDetails: mockPolicyDetails,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle(
        const Duration(milliseconds: 200),
      );

      final foundSwitch = find.byType(SwitchListTile);
      final SwitchListTile switchWidget = tester.widget(foundSwitch);

      expect(foundSwitch, findsOneWidget);
      expect(switchWidget.value, false);

      final foundSnackbar = find.byType(TfbSnackbarContent);
      expect(foundSnackbar, findsOneWidget);

      final foundSnackbarText =
          find.text(AppLocalizationsEn().somethingWentWrong);
      expect(foundSnackbarText, findsOneWidget);
    },
  );
}
