import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/file_a_claim_auto_form/file_an_auto_claim_form_content.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_insured_driver.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/insured_vehicle_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/is_vehicle_drivable.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/was_another_party_involved.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_form_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_type_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/bottom_sheet_type_of_loss.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/loss_and_damage_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/state_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/preferred_section/preferred_section.dart';

import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/bottom_sheet_reporter_type.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/name_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/reporter_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../mocks/mock_submit_claim_bloc.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../mocks/models/auto_claim.dart';
import '../../../widgets/tfb_widget_tester.dart';
import '../../blocs/claims/submit_claims_bloc_test.dart';

void main() {
  late MockSubmitClaimBloc submitClaimBloc;
  late MockTfbNavigator mockNavigator;

  setUp(
    () {
      VisibilityDetectorController.instance.updateInterval = Duration.zero;
      registerFallbackValue(SubmitClaimInitState());
      registerFallbackValue(
        PolicySelection(
          insuredName: 'insured name',
          policyNumber: 'policy number',
          policySymbol: 'policy symbol',
          policyType: PolicyType.txPersonalAuto,
        ),
      );
      registerFallbackValue(
        ClaimSubmission(
          policyType: PolicyType.txPersonalAuto,
          claimFormAnswers: MockAutoClaim.getAutoClaim(),
          policySelection: MockAutoClaim.getAutoPolicySelection(),
          dateOfLoss: '01/01/2023',
        ),
      );
      submitClaimBloc = MockSubmitClaimBloc();
      mockNavigator = MockTfbNavigator();
      tz.initializeTimeZones();
      final expectedStates = [
        SubmitClaimInitState(),
        mockClaimFormInitSuccess,
      ];
      whenListen(
        submitClaimBloc,
        Stream.fromIterable(expectedStates),
        initialState: SubmitClaimInitState(),
      );
      when(
        () => mockNavigator.pushCancelClaimsDialog(
          any<PolicySelection>(),
        ),
      ).thenAnswer((invocation) async => Future<void>.value());
      when(
        () => mockNavigator.pushToAddPhotosAutoPage(
          any<ClaimSubmission>(),
        ),
      ).thenAnswer((invocation) async => Future<void>.value());
    },
  );

  testWidgets(
    'File an Auto Claim form page should render form sections',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAnAutoClaimFormContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.txPersonalAuto,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '02/20/2018',
            ),
          ),
        ),
      );

      expect(
        find.byType(FileAClaimFormHeader),
        findsOneWidget,
      );
      expect(
        find.byType(ReporterInfoSection),
        findsOneWidget,
      );
      expect(
        find.byType(PreferredSection),
        findsOneWidget,
      );
      expect(
        find.byType(LossAndDamageSection),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'File claim button, when filling all required form fields, should be enabled and navigate to add photos',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAnAutoClaimFormContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.txPersonalAuto,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '02/20/2018',
            ),
          ),
        ),
      );

      // Fill prefered contact info
      await tester.enterText(
        find.byType(ContactPhoneNumberFormField).first,
        '1234567890',
      );

      await selectOptionInBottomSheet(
        tester,
        find.byType(ContactTypeBottomSheet).first,
      );

      // Fill reporter information
      await tester.enterText(
        find.byType(NameFormField),
        'John Doe',
      );

      await selectOptionInBottomSheet(
        tester,
        find.byType(BottomSheetReporterType),
      );

      await tester.enterText(
        find.byType(ContactPhoneNumberFormField).at(1),
        '1234567890',
      );

      await selectOptionInBottomSheet(
        tester,
        find.byType(ContactTypeBottomSheet).at(1),
      );

      //Fill loss and damage
      final widget = find.text(AppLocalizationsEn().timeOfLossTextFormField);
      await tester.ensureVisible(widget);
      await tester.pumpAndSettle();
      await tester.tap(widget);
      await tester.pump(
        const Duration(milliseconds: 500),
      );

      final okButton = find.text('OK');
      await tester.ensureVisible(okButton);
      await tester.tap(okButton);
      await tester.pumpAndSettle();

      //Type of loss Field
      await selectOptionInBottomSheet(
        tester,
        find.byType(TypeOfLossBottomSheet).first,
      );

      //Description Field
      final descriptionField = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.labelText == AppLocalizationsEn().additionalDescLossLabel,
      );

      await tester.ensureVisible(descriptionField);
      await tester.pumpAndSettle();
      await tester.enterText(descriptionField, 'This is a description');

      //Location Field
      final locationField = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.labelText == AppLocalizationsEn().locationTextFormField,
      );

      await tester.ensureVisible(locationField);
      await tester.pumpAndSettle();
      await tester.enterText(locationField, 'This is a Location');

      //State Field
      await tester.tap(
        find.byType(StateBottomSheet),
      );

      await tester.pump(
        const Duration(milliseconds: 500),
      );

      final stateWidget = find.text('Alabama');
      await tester.ensureVisible(stateWidget);
      await tester.pumpAndSettle();
      await tester.tap(stateWidget);
      await tester.pumpAndSettle();

      //City Field
      final cityField = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.labelText == AppLocalizationsEn().cityFormField,
      );

      await tester.ensureVisible(cityField);
      await tester.pumpAndSettle();
      await tester.enterText(cityField, 'This is a City');

      //Police Department Field
      final policeDepartmentField = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.labelText == AppLocalizationsEn().policeDepartmentFormField,
      );
      await tester.ensureVisible(cityField);
      await tester.pumpAndSettle();
      await tester.enterText(
        policeDepartmentField,
        'This is a Police Department',
      );

      //Police Case Number Field
      final policeCaseNumberField = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.labelText == AppLocalizationsEn().policeCaseNumberFormField,
      );
      await tester.ensureVisible(cityField);
      await tester.pumpAndSettle();
      await tester.enterText(
        policeCaseNumberField,
        'This is a Case Number',
      );

      await selectOptionInBottomSheet(
        tester,
        find.byType(InsuredDriversBottomSheet),
      );

      //Insured Vehicle Field
      await selectOptionInBottomSheet(
        tester,
        find.byType(InsuredVehicleBottomSheet),
      );

      //Vehicle is drivable field
      final isDrivableWidget =
          find.byWidgetPredicate((widget) => widget is IsVehicleDrivable);

      final isDrivableYesWidget = find.byWidgetPredicate((widget) {
        final w = widget is YesNoButton;
        return w && widget.kind == YesNoButtonKind.yes;
      }).first;

      await tester.ensureVisible(isDrivableWidget);
      await tester.ensureVisible(isDrivableYesWidget);
      await tester.tap(isDrivableYesWidget);
      await tester.pumpAndSettle();

      //Was anyone hurt field
      final wasAnyoneHurtWidget =
          find.byWidgetPredicate((widget) => widget is IsVehicleDrivable);

      final wasAnyoneHurtNoOption = find.byWidgetPredicate((widget) {
        final w = widget is YesNoButton;
        return w && widget.kind == YesNoButtonKind.no;
      }).at(1);

      await tester.ensureVisible(wasAnyoneHurtWidget);
      await tester.ensureVisible(wasAnyoneHurtNoOption);
      await tester.tap(wasAnyoneHurtNoOption);
      await tester.pumpAndSettle();

      // Another party involved
      final wasAnotherPartyInvolvedWidget =
          find.byWidgetPredicate((widget) => widget is WasAnotherPartyInvolved);

      final wasAnotherPartyInvolvedNoOption = find.byWidgetPredicate((widget) {
        final w = widget is YesNoButton;
        return w && widget.kind == YesNoButtonKind.no;
      }).at(2);

      await tester.ensureVisible(wasAnotherPartyInvolvedWidget);
      await tester.ensureVisible(wasAnotherPartyInvolvedNoOption);
      await tester.tap(wasAnotherPartyInvolvedNoOption);
      await tester.pumpAndSettle();

      //Submit a claim button
      await tester.tap(
        find.byType(TfbFilledButton),
      );
      await tester.pumpAndSettle();

      //navigate to photos screen
      verify(() => mockNavigator.pushToAddPhotosAutoPage(any())).called(1);
    },
  );

  testWidgets(
    'Tapping on file claim button without filling out any form fields should do nothing',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAnAutoClaimFormContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.txPersonalAuto,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '02/20/2018',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TfbFilledButton));
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (widget) => widget is TfbFilledButton && widget.enabled == false,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets('Testing loading state', (tester) async {
    when(() => submitClaimBloc.state).thenReturn(
      mockSubmitClaimProcessingState,
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: FileAnAutoClaimFormContent(
            policySelection: PolicySelection(
              insuredName: '',
              policyNumber: '',
              policyType: PolicyType.txPersonalAuto,
              policySymbol: 'HO6',
            ),
            dateOfLoss: '',
          ),
        ),
      ),
    );

    expect(find.text(AppLocalizationsEn().cancel), findsNothing);
    expect(
      find.byWidgetPredicate((widget) => widget is TfbLoadingOverlay),
      findsOneWidget,
    );
  });

  testWidgets(
    'Testing error loading state when submit form API call',
    (tester) async {
      final mockTfbFileClaimRepository = MockTfbFileClaimRepository();

      when(
        () => mockTfbFileClaimRepository.getFormData(
          '123',
          policySymbol: '123',
          claimDate: '123',
          isAutoClaim: true,
        ),
      ).thenThrow(
        Exception(),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<SubmitClaimBloc>.value(
              value: SubmitClaimBloc(fileClaimRepo: mockTfbFileClaimRepository),
              child: FileAnAutoClaimFormContent(
                policySelection: PolicySelection(
                  insuredName: '123',
                  policyNumber: '123',
                  policyType: PolicyType.homeowners,
                  policySymbol: '123',
                ),
                dateOfLoss: '12/12/2001',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final snackBarFinder = find.byType(SnackBar);
      await tester.pumpAndSettle();

      expect(snackBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'When click on Cancel CTA, a dialog must appear',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAnAutoClaimFormContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.txPersonalAuto,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '02/20/2018',
            ),
          ),
        ),
      );

      //Cancel button
      final cancelButton = find.byWidgetPredicate(
        (widget) => widget is CancelAppBarAction,
      );
      await tester.ensureVisible(cancelButton);
      await tester.pumpAndSettle();
      await tester.tap(cancelButton);
      await tester.pumpAndSettle();

      verify(() => mockNavigator.pushCancelClaimsDialog(any())).called(1);
    },
  );

  testWidgets(
    'Submit Claim Button should be elevated and with shadow',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAnAutoClaimFormContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.txPersonalAuto,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '02/20/2018',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final tfbDrop = tester.widget<TfbDropShadowScrollWidget>(
        find.byType(TfbDropShadowScrollWidget),
      );

      final findAnimated = find.byWidgetPredicate(
        (widget) =>
            widget is AnimatedOpacity &&
            widget.child is Container &&
            (widget.child as Container).alignment == Alignment.bottomCenter,
      );
      final widgetAnimated = tester.widget<AnimatedOpacity>(findAnimated);

      expect(widgetAnimated.opacity, 1);
      await tester.dragUntilVisible(
        find.byType(WasAnotherPartyInvolved),
        find.byType(ListView),
        const Offset(0, 100),
      );
      await tester.pumpAndSettle();
      final findAnimatedNew = find.byWidgetPredicate(
        (widget) =>
            widget is AnimatedOpacity &&
            widget.child is Container &&
            (widget.child as Container).alignment == Alignment.bottomCenter,
      );
      final widgetAnimatedNew = tester.widget<AnimatedOpacity>(findAnimatedNew);
      expect(
        widgetAnimatedNew.opacity,
        0,
      );
      expect(
        find.byType(TfbFilledButton),
        findsOneWidget,
      );
      expect(tfbDrop.showFooterShadow, true);
    },
  );
}

Future<void> selectOptionInBottomSheet(
  WidgetTester tester,
  Finder bottomSheet,
) async {
  await tester.ensureVisible(bottomSheet);
  await tester.pumpAndSettle();
  await tester.tap(
    bottomSheet,
  );
  await tester.pumpAndSettle();
  final widgetToTap = find.byType(BottomSheetSelectorOptionButton).first;
  await tester.ensureVisible(widgetToTap);
  await tester.pumpAndSettle();
  await tester.tap(widgetToTap);
  await tester.pumpAndSettle();
}
