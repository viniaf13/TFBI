import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/file_a_claim_homeowner_form/file_a_claim_home_owner_form_content.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_form_header.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_type_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/bottom_sheet_type_of_loss.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/county_of_loss_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/loss_and_damage_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/police_case_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/state_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/preferred_section/preferred_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/bottom_sheet_reporter_type.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/name_form_field.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';
import 'package:txfb_insurance_flutter/shared/widgets/cancel_app_bar_action.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_loading_overlay.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../../mocks/mock_submit_claim_bloc.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../mocks/models/property_claim.dart';
import '../../../widgets/tfb_widget_tester.dart';

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
          policyType: PolicyType.homeowners,
        ),
      );
      registerFallbackValue(
        ClaimSubmission(
          policyType: PolicyType.homeowners,
          claimFormAnswers: MockPropertyClaim.getPropertyClaim(),
          policySelection: MockPropertyClaim.getPropertyPolicySelection(),
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
      when(() => submitClaimBloc.state).thenReturn(
        mockClaimFormInitSuccess,
      );
      when(
        () => mockNavigator.pushCancelClaimsDialog(
          any<PolicySelection>(),
        ),
      ).thenAnswer((invocation) async => Future<void>.value());
      when(
        () => mockNavigator.pushToAddPhotosHomeOwnerPage(
          any<ClaimSubmission>(),
        ),
      ).thenAnswer((invocation) async => Future<void>.value());
    },
  );

  testWidgets(
    'File a claim page should render a File a Claim Header, Preferred Section and loss and damage section',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAClaimHomeOwnerContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.homeowners,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '',
            ),
          ),
        ),
      );
      expect(
        find.byType(FileAClaimFormHeader),
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
    'File claim button, when filling all required form fields, should navigate to add photos page',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: Scaffold(
              body: FileAClaimHomeOwnerContent(
                policySelection: PolicySelection(
                  insuredName: '',
                  policyNumber: '',
                  policyType: PolicyType.homeowners,
                  policySymbol: 'HO6',
                ),
                dateOfLoss: '02/20/2018',
              ),
            ),
          ),
        ),
      );
      // Fill preferred contact info
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

      //Type of loss Field
      await selectOptionInBottomSheet(
        tester,
        find.byType(TypeOfLossBottomSheet).first,
      );

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

      //Submit a claim button
      await tester.tap(
        find.byType(TfbFilledButton),
      );
      await tester.pumpAndSettle();

      //navigate to photos screen
      verify(() => mockNavigator.pushToAddPhotosHomeOwnerPage(any())).called(1);
    },
  );

  testWidgets(
    'Tapping on file claim button without filling out any form fields should do nothing',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAClaimHomeOwnerContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.homeowners,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '',
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
          child: FileAClaimHomeOwnerContent(
            policySelection: PolicySelection(
              insuredName: '',
              policyNumber: '',
              policyType: PolicyType.homeowners,
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
      'When Texas state is selected, then County of Loss bottom sheet is visible',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: FileAClaimHomeOwnerContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.homeowners,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '',
            ),
          ),
        ),
      ),
    );

    //State Field
    await tester.tap(
      find.byType(StateBottomSheet),
    );
    await tester.pump(
      const Duration(milliseconds: 500),
    );
    final stateWidget = find.text('Texas');
    await tester.ensureVisible(stateWidget);
    await tester.pumpAndSettle();
    await tester.tap(stateWidget);
    await tester.pumpAndSettle();

    expect(
      find.byType(CountyOfLossBottomSheet),
      findsOneWidget,
    );
  });

  testWidgets(
      'When state other than Texas is selected, then County of Loss bottom sheet is not visible',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: FileAClaimHomeOwnerContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.homeowners,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '',
            ),
          ),
        ),
      ),
    );

    final stateWidget = find.byType(StateBottomSheet, skipOffstage: false);
    await tester.ensureVisible(stateWidget);
    await tester.pumpAndSettle();

    //State Field
    await tester.tap(stateWidget);
    await tester.pump(
      const Duration(milliseconds: 500),
    );
    final stateWidgetSelection = find.text('Alabama');
    await tester.ensureVisible(stateWidgetSelection);
    await tester.pumpAndSettle();
    await tester.tap(stateWidgetSelection);
    await tester.pumpAndSettle();

    expect(
      find.byType(CountyOfLossBottomSheet),
      findsNothing,
    );
  });

  testWidgets(
    'When click on Cancel CTA, a dialog must appear',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: Scaffold(
              body: FileAClaimHomeOwnerContent(
                policySelection: PolicySelection(
                  insuredName: '',
                  policyNumber: '',
                  policyType: PolicyType.homeowners,
                  policySymbol: '',
                ),
                dateOfLoss: '',
              ),
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

      //Dialog must appear
      verify(() => mockNavigator.pushCancelClaimsDialog(any())).called(1);
    },
  );

  testWidgets(
    'Submit Claim Button should be elevated and with shadow',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: FileAClaimHomeOwnerContent(
              policySelection: PolicySelection(
                insuredName: '',
                policyNumber: '',
                policyType: PolicyType.homeowners,
                policySymbol: 'HO6',
              ),
              dateOfLoss: '',
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
        find.byType(PoliceCaseNumberFormField),
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
