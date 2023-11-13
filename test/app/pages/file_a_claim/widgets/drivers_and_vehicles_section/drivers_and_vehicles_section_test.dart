import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_state.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_state.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_insured_driver.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/drivers_and_vehicles_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/is_vehicle_drivable.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/was_another_party_involved.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/was_anyone_injured.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/yesno_button.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_primary_insured.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/bottom_sheet_selector.dart';

import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../../../mocks/bloc/mock_vehicle_make_cubit.dart';
import '../../../../../mocks/bloc/mock_vehicle_model_cubit.dart';
import '../../../../../mocks/mock_environment_notifier.dart';
import '../../../../../mocks/mock_submit_claim_bloc.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  final TfbUser testUser = TfbUser(
    accessToken: 'testAccessToken',
    username: 'username',
    agentNumber: 'agentNumber',
    communicationPreferred: 'communicationPreferred',
    emailVerified: true,
    errorMessage: 'errorMessage',
    memberName: 'memberName',
    memberSecondaryName: 'memberSecondaryName',
    passwordResetFlag: false,
    sessionCookie: 'sessionCookie',
    memberEmailAddress: 'memberEmailAddress',
    members: [
      LoginMember(
        lastLoginTimestamp: 'lastLoginTimestamp',
        memberIDNumber: 1234,
        memberNumber: '1234',
      ),
    ],
  );
  late MockSubmitClaimBloc submitClaimBloc;
  late AuthBloc mockAuthBloc;
  late MockEnvironmentNotifier mockEnvironmentNotifier;
  late MockVehicleMakeCubit mockVehicleMakeCubit;
  late MockModelVehicleCubit mockModelMakeCubit;
  late ValueNotifier<AutoPrimaryInsured> insuredDriverInfoNotifier;
  late ValueNotifier<SubmitClaimVehicle> insuredVehicleInfoNotifier;
  late ValueNotifier<AutoPrimaryInsured?> thirdPartyDriverInfoNotifier;
  late ValueNotifier<SubmitClaimVehicle?> thirdPartyVehicleInfoNotifier;
  late ValueNotifier<bool> isNewDriver;
  late ValueNotifier<bool> formHasBeenSubmited;

  setUp(
    () {
      mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));

      registerFallbackValue(SubmitClaimInitState());
      submitClaimBloc = MockSubmitClaimBloc();
      when(() => submitClaimBloc.state).thenReturn(
        mockClaimFormInitSuccess,
      );

      mockEnvironmentNotifier = MockEnvironmentNotifier();
      when(() => mockEnvironmentNotifier.environment).thenReturn(
        TfbEnvironmentDev(),
      );

      mockVehicleMakeCubit = MockVehicleMakeCubit();
      when(() => mockVehicleMakeCubit.state).thenReturn(
        VehicleMakeSuccess(
          makes: [
            const SubmitClaimVehicleMake(
              key: 'key',
              value: 'value',
            ),
          ],
        ),
      );
      mockModelMakeCubit = MockModelVehicleCubit();
      when(() => mockModelMakeCubit.state).thenReturn(
        VehicleModelSuccess(
          models: [
            VehicleModelResponse(
              key: 'key',
              value: 'value',
            ),
          ],
        ),
      );
      insuredDriverInfoNotifier =
          ValueNotifier<AutoPrimaryInsured>(const AutoPrimaryInsured());
      insuredVehicleInfoNotifier =
          ValueNotifier<SubmitClaimVehicle>(const SubmitClaimVehicle());
      thirdPartyDriverInfoNotifier = ValueNotifier<AutoPrimaryInsured?>(null);
      thirdPartyVehicleInfoNotifier = ValueNotifier<SubmitClaimVehicle?>(null);
      isNewDriver = ValueNotifier(false);
      formHasBeenSubmited = ValueNotifier(false);
    },
  );

  testWidgets(
      'DriversAndVehiclesSection should render title, subtitle and bottom sheet selectors',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: SingleChildScrollView(
              child: DriversAndVehiclesSection(
                isFormValid: ValueNotifier<bool>(true),
                insuredDriverInfoNotifier: insuredDriverInfoNotifier,
                insuredVehicleInfoNotifier: insuredVehicleInfoNotifier,
                thirdPartyDriverInfoNotifier: thirdPartyDriverInfoNotifier,
                thirdPartyVehicleInfoNotifier: thirdPartyVehicleInfoNotifier,
                isNewDriverNotifier: isNewDriver,
                hasFormBeenSubmitedNotifier: formHasBeenSubmited,
              ),
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().driversAndVehiclesHeaderTitle),
      findsOneWidget,
    );
    expect(
      find.text(
        'If you need to select a vehicle that is not listed here, please call 8002665458.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredVehicleFieldLabel),
      findsOneWidget,
    );
  });

  testWidgets(
      'DriversAndVehiclesSection should render insured driver information fields when Other is selected',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: SingleChildScrollView(
              child: DriversAndVehiclesSection(
                isFormValid: ValueNotifier<bool>(true),
                insuredDriverInfoNotifier: insuredDriverInfoNotifier,
                insuredVehicleInfoNotifier: insuredVehicleInfoNotifier,
                thirdPartyDriverInfoNotifier: thirdPartyDriverInfoNotifier,
                thirdPartyVehicleInfoNotifier: thirdPartyVehicleInfoNotifier,
                isNewDriverNotifier: isNewDriver,
                hasFormBeenSubmitedNotifier: formHasBeenSubmited,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(
      find.byType(InsuredDriversBottomSheet),
    );
    await tester.pump(
      const Duration(milliseconds: 500),
    );
    final otherOption = find.text(AppLocalizationsEn().insuredDriverOtherLabel);
    await tester.ensureVisible(otherOption);
    await tester.pumpAndSettle();
    await tester.tap(otherOption);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().insuredDriverFirstNameFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLastNameFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLicenseNumberFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLicenseStateFieldLabel),
      findsOneWidget,
    );
  });

  testWidgets(
      'DriversAndVehiclesSection should not render insured driver information fields when Other is selected',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: SingleChildScrollView(
              child: DriversAndVehiclesSection(
                isFormValid: ValueNotifier<bool>(true),
                insuredDriverInfoNotifier: insuredDriverInfoNotifier,
                insuredVehicleInfoNotifier: insuredVehicleInfoNotifier,
                thirdPartyDriverInfoNotifier: thirdPartyDriverInfoNotifier,
                thirdPartyVehicleInfoNotifier: thirdPartyVehicleInfoNotifier,
                isNewDriverNotifier: isNewDriver,
                hasFormBeenSubmitedNotifier: formHasBeenSubmited,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(
      find.byType(InsuredDriversBottomSheet),
    );
    await tester.pump(
      const Duration(milliseconds: 500),
    );
    final driverNameButton = find.byType(BottomSheetSelectorOptionButton).first;
    await tester.ensureVisible(driverNameButton);
    await tester.pumpAndSettle();
    await tester.tap(driverNameButton);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().insuredDriverFirstNameFieldLabel),
      findsNothing,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLastNameFieldLabel),
      findsNothing,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLicenseNumberFieldLabel),
      findsNothing,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLicenseStateFieldLabel),
      findsNothing,
    );
  });

  testWidgets(
      'DriversAndVehiclesSection should render other party involved information fields when Yes is selected',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: Scaffold(
              body: SingleChildScrollView(
                child: DriversAndVehiclesSection(
                  isFormValid: ValueNotifier<bool>(true),
                  insuredDriverInfoNotifier: insuredDriverInfoNotifier,
                  insuredVehicleInfoNotifier: insuredVehicleInfoNotifier,
                  thirdPartyDriverInfoNotifier: thirdPartyDriverInfoNotifier,
                  thirdPartyVehicleInfoNotifier: thirdPartyVehicleInfoNotifier,
                  isNewDriverNotifier: isNewDriver,
                  hasFormBeenSubmitedNotifier: formHasBeenSubmited,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final wasAnotherPartyInvolvedWidget =
        find.byWidgetPredicate((widget) => widget is WasAnotherPartyInvolved);

    final wasAnotherPartyInvolvedYesOption = find.byWidgetPredicate((widget) {
      final w = widget is YesNoButton;
      return w && widget.kind == YesNoButtonKind.yes;
    }).at(2);

    await tester.ensureVisible(wasAnotherPartyInvolvedWidget);
    await tester.ensureVisible(wasAnotherPartyInvolvedYesOption);
    await tester.tap(wasAnotherPartyInvolvedYesOption);
    await tester.pump();

    expect(
      find.text(AppLocalizationsEn().anotherPartyDriverTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverFirstNameFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLastNameFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().streetAddressFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().state),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().cityFormField),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().zipCodeFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().phoneNumberTextFormField),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLicenseNumberFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().insuredDriverLicenseStateFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().anotherPartyVehicleTitle),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().driversLicensePlateNumberLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().driversLicensePlateStateLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().ownerFirstNameFieldLabel),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().ownerLastNameFieldLabel),
      findsOneWidget,
    );
    expect(
      find.byType(IsVehicleDrivable),
      findsNWidgets(2),
    );
    expect(
      find.byType(WasAnyoneInjured),
      findsNWidgets(2),
    );
  });

  testWidgets(
      'DriversAndVehiclesSection should not render other party involved information fields when No is selected',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: SingleChildScrollView(
              child: DriversAndVehiclesSection(
                isFormValid: ValueNotifier<bool>(true),
                insuredDriverInfoNotifier: insuredDriverInfoNotifier,
                insuredVehicleInfoNotifier: insuredVehicleInfoNotifier,
                thirdPartyDriverInfoNotifier: thirdPartyDriverInfoNotifier,
                thirdPartyVehicleInfoNotifier: thirdPartyVehicleInfoNotifier,
                isNewDriverNotifier: isNewDriver,
                hasFormBeenSubmitedNotifier: formHasBeenSubmited,
              ),
            ),
          ),
        ),
      ),
    );

    final wasAnotherPartyInvolvedWidget =
        find.byWidgetPredicate((widget) => widget is WasAnotherPartyInvolved);

    final wasAnotherPartyInvolvedNoOption = find.byWidgetPredicate((widget) {
      final w = widget is YesNoButton;
      return w && widget.kind == YesNoButtonKind.no;
    }).at(2);

    await tester.ensureVisible(wasAnotherPartyInvolvedWidget);
    await tester.ensureVisible(wasAnotherPartyInvolvedNoOption);
    await tester.tap(wasAnotherPartyInvolvedNoOption);
    await tester.pump();

    expect(
      find.text(AppLocalizationsEn().anotherPartyDriverTitle),
      findsNothing,
    );
    expect(
      find.text(AppLocalizationsEn().anotherPartyVehicleTitle),
      findsNothing,
    );
  });

  testWidgets(
    'DriversAndVehiclesSection should not render Other Party Driver fields when Was Another party is not involved',
    (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: ChangeNotifierProvider<EnvironmentNotifier>(
              create: (context) => mockEnvironmentNotifier,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: DriversAndVehiclesSection(
                    isFormValid: ValueNotifier<bool>(true),
                    insuredDriverInfoNotifier: insuredDriverInfoNotifier,
                    insuredVehicleInfoNotifier: insuredVehicleInfoNotifier,
                    thirdPartyDriverInfoNotifier: thirdPartyDriverInfoNotifier,
                    thirdPartyVehicleInfoNotifier:
                        thirdPartyVehicleInfoNotifier,
                    isNewDriverNotifier: isNewDriver,
                    hasFormBeenSubmitedNotifier: formHasBeenSubmited,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      //Yes Button from WasAnotherPartyEnvolved widget
      final noButton = find.byWidgetPredicate((widget) {
        final w = widget is YesNoButton;
        return w && widget.kind == YesNoButtonKind.no;
      }).at(2);

      await tester.ensureVisible(noButton);
      await tester.tap(noButton);
      await tester.pumpAndSettle();

      //Verify if Vehicle Year, Make and Model are present
      //Year
      expect(
        find.text(AppLocalizationsEn().vehicleYearLabel),
        findsNothing,
      );

      //Make
      expect(
        find.text(AppLocalizationsEn().vehicleMakeLabel),
        findsNothing,
      );

      //Model
      expect(
        find.text(AppLocalizationsEn().vehicleModelLabel),
        findsNothing,
      );
    },
  );
}
