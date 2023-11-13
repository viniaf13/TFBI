import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/auto_loss_types_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/phone_types_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/reporter_types_enum.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/enum/submit_claim_us_states.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/claim_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/vehicles.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_phone_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_types.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

class MockSubmitClaimBloc extends MockBloc<SubmitClaimEvent, SubmitClaimState>
    implements SubmitClaimBloc {}

//TODO fill this mock as new fields are added to form
final mockClaimFormInitSuccess = SubmitClaimFormInitSuccess(
  claimFormData: ClaimFormData(
    contactType: [
      SubmitClaimPhoneTypes(
        usageTypeCode: '',
        usageTypeName: PhoneTypesEnum.busn_phn,
      ),
    ],
    county: [],
    insuredDrivers: [
      Driver('', '', '', 'John', 'John Doe', '', 'Doe', '', '', ''),
    ],
    insuredVehicles: [
      Vehicle(
        '',
        '',
        [],
        [],
        [],
        [],
        '',
        '',
        '',
        'Make',
        'Model',
        '',
        '',
        '',
        '',
        '',
        'Year',
      ),
    ],
    reporterType: [
      SubmitClaimReporterTypes(
        key: ReporterTypesEnum.insured.value,
        value: ReporterTypesEnum.insured,
      ),
    ],
    typeOfLoss: [
      SubmitClaimAutoLossTypes(
        name: AutoLossTypesEnum.pafire,
      ),
    ],
    vehicleYears: [const SubmitClaimVehicleYear(key: '2023', value: '2023')],
    state: [
      SubmitClaimUsStates.TX,
      SubmitClaimUsStates.AL,
    ],
    policyDetails: PolicyDetails(
      vehicles: [
        Vehicles(
          year: 'Year',
          make: 'Make',
          model: 'Model',
        ),
      ],
    ),
  ),
);

final mockSubmitClaimFormInitFailure = SubmitClaimFormInitFailure(error: null);

final mockSubmitClaimProcessingState = SubmitClaimProcessingState();

final mockSubmitPropertyClaimFailureState = SubmitPropertyClaimFailureState(
  error: TfbRequestError(message: 'Error'),
);

final mockSubmitPropertyClaimSuccessState = SubmitPropertyClaimSuccessState(
  data: PropertyClaimSubmissionResponse(
    referenceNumber: '1',
    claimNumber: '1',
    submissionStatus: 'ok',
    adjuster: 'none',
  ),
);

final mockSubmitAutoClaimSuccessState = SubmitAutoClaimSuccessState(
  data: AutoClaimSubmissionResponse(
    referenceNumber: '1',
    claimNumber: '1',
    submissionStatus: 'ok',
    adjuster: Adjuster(
      email: 'mock@mock.com',
      id: '1',
      name: 'mock',
      office: Office(
        number: '1',
        phone: '1',
      ),
    ),
  ),
);

final mockSubmitAutoClaimFailureState = SubmitAutoClaimFailureState(
  error: TfbRequestError(
    message: 'mockError',
  ),
);
