import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/claim_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';

import '../../../mocks/models/property_claim.dart';

class MockTfbFileClaimRepository extends Mock
    implements TfbFileClaimRepository {}

void main() {
  late SubmitClaimBloc submitClaimBloc;
  late MockTfbFileClaimRepository mockTfbFileClaimRepository;

  const claimFormData = ClaimFormData(
    contactType: [],
    reporterType: [],
    typeOfLoss: [],
    county: [],
    state: [],
    insuredDrivers: [],
    insuredVehicles: [],
    vehicleYears: [],
    policyDetails: null,
  );

  final policySelection = PolicySelection(
    policyNumber: '',
    policyType: PolicyType.txPersonalAuto,
    insuredName: '',
    policySymbol: '',
  );

  final propertyClaimSubmissionResponse = PropertyClaimSubmissionResponse(
    referenceNumber: '1',
    claimNumber: null,
    submissionStatus: 'SUCCESS',
    adjuster: null,
  );

  setUp(() {
    mockTfbFileClaimRepository = MockTfbFileClaimRepository();
    submitClaimBloc =
        SubmitClaimBloc(fileClaimRepo: mockTfbFileClaimRepository);

    registerFallbackValue(MockPropertyClaim.getPropertyClaim());
  });

  tearDown(() {
    submitClaimBloc.close();
  });

  blocTest<SubmitClaimBloc, SubmitClaimState>(
    'emits [SubmitClaimPolicyListSuccessState] when policy list is retrieved',
    build: () {
      when(() => mockTfbFileClaimRepository.getPolicySelections()).thenAnswer(
        (_) async => [policySelection],
      );
      return submitClaimBloc;
    },
    act: (bloc) => bloc.add(SubmitClaimGetPolicyListEvent()),
    expect: () => [
      SubmitClaimProcessingState(),
      SubmitClaimPolicyListSuccessState(
        policies: [policySelection],
      ),
    ],
  );

  blocTest<SubmitClaimBloc, SubmitClaimState>(
    'emits [SubmitClaimPolicyListFailureState] when getting policy list fails',
    build: () {
      when(() => mockTfbFileClaimRepository.getPolicySelections()).thenAnswer(
        (_) => Future.value([]),
      );
      return submitClaimBloc;
    },
    act: (bloc) => bloc.add(SubmitClaimGetPolicyListEvent()),
    expect: () => [
      SubmitClaimProcessingState(),
      isA<SubmitClaimPolicyListFailureState>(),
    ],
  );

  blocTest<SubmitClaimBloc, SubmitClaimState>(
    'emits [SubmitClaimProcessingState, SubmitClaimFormInitSuccess] when form data is retrieved',
    build: () {
      when(
        () => mockTfbFileClaimRepository.getFormData(
          any(),
          isAutoClaim: any(named: 'isAutoClaim'),
          policySymbol: any(named: 'policySymbol'),
          claimDate: any(named: 'claimDate'),
        ),
      ).thenAnswer((_) async => claimFormData);
      return submitClaimBloc;
    },
    act: (bloc) => bloc.add(
      ClaimFormInitEvent(
        selectedPolicy: policySelection,
        dateOfLoss: '2023-01-01',
      ),
    ),
    expect: () => [
      SubmitClaimProcessingState(),
      SubmitClaimFormInitSuccess(
        claimFormData: claimFormData,
      ),
    ],
  );

  blocTest<SubmitClaimBloc, SubmitClaimState>(
    'emits [SubmitClaimProcessingState, SubmitClaimFormInitFailure] when getting form data fails',
    build: () {
      when(
        () => mockTfbFileClaimRepository.getFormData(
          any(),
          isAutoClaim: any(named: 'isAutoClaim'),
        ),
      ).thenThrow(
        Exception(),
      );
      return submitClaimBloc;
    },
    act: (bloc) => bloc.add(
      ClaimFormInitEvent(
        selectedPolicy: policySelection,
        dateOfLoss: '2023-01-01',
      ),
    ),
    expect: () => [
      SubmitClaimProcessingState(),
      isA<SubmitClaimFormInitFailure>(),
    ],
  );

  blocTest<SubmitClaimBloc, SubmitClaimState>(
    'emits [SubmitPropertyClaimProcessingState, SubmitPropertyClaimSuccessState] when submitting a property claim',
    build: () {
      when(
        () => mockTfbFileClaimRepository.filePropertyClaim(
          any(),
        ),
      ).thenAnswer((_) async => propertyClaimSubmissionResponse);
      return submitClaimBloc;
    },
    act: (bloc) => bloc.add(
      SubmitPropertyClaimEvent(
        propertyClaimSubmission: MockPropertyClaim.getPropertyClaim(),
      ),
    ),
    expect: () => [
      SubmitPropertyClaimProcessingState(),
      isA<SubmitPropertyClaimSuccessState>(),
    ],
  );

  blocTest<SubmitClaimBloc, SubmitClaimState>(
    'emits [SubmitPropertyClaimProcessingState, SubmitPropertyClaimFailureState] when submitting a property claim fails',
    build: () {
      when(
        () => mockTfbFileClaimRepository.filePropertyClaim(
          any(),
        ),
      ).thenThrow(
        Exception(),
      );
      return submitClaimBloc;
    },
    act: (bloc) => bloc.add(
      SubmitPropertyClaimEvent(
        propertyClaimSubmission: MockPropertyClaim.getPropertyClaim(),
      ),
    ),
    expect: () => [
      SubmitPropertyClaimProcessingState(),
      isA<SubmitPropertyClaimFailureState>(),
    ],
  );
}
