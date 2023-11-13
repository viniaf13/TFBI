import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_year/vehicle_year_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_year/vehicle_year_state.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

class MockFileAClaimClient extends Mock implements FileAClaimClient {}

class MockTfbDocumentInformationClient extends Mock
    implements TfbDocumentInformationClient {}

class MockTfbPolicyLookupRepository extends Mock
    implements TfbPolicyLookupRepository {}

void main() {
  late FileAClaimClient mockFileAClaimClient;

  setUp(() {
    mockFileAClaimClient = MockFileAClaimClient();
  });

  test('VehicleYearCubit should start in the VehicleYearInitial state', () {
    expect(
      VehicleYearCubit(
        fileClaimRepository: TfbFileClaimRepository(
          fileClaimClient: mockFileAClaimClient,
          documentClient: MockTfbDocumentInformationClient(),
          policyLookUp: MockTfbPolicyLookupRepository(),
        ),
      ).state,
      isA<VehicleYearInitial>(),
    );
  });

  blocTest<VehicleYearCubit, VehicleYearState>(
    'If getVehicleYears call fails, state should be a VehicleYearFailure',
    build: () => VehicleYearCubit(
      fileClaimRepository: TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: MockTfbDocumentInformationClient(),
        policyLookUp: MockTfbPolicyLookupRepository(),
      ),
    ),
    setUp: () {
      when(
        () => mockFileAClaimClient.getVehicleYears(),
      ).thenThrow(Exception('ERROR'));
    },
    act: (cubit) => cubit.getVehicleYears(),
    expect: () => [isA<VehicleYearProcessing>(), isA<VehicleYearFailure>()],
  );

  blocTest<VehicleYearCubit, VehicleYearState>(
    'If getVehicleYears call succeeds, state should be a VehicleYearSuccess',
    build: () => VehicleYearCubit(
      fileClaimRepository: TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: MockTfbDocumentInformationClient(),
        policyLookUp: MockTfbPolicyLookupRepository(),
      ),
    ),
    setUp: () {
      when(
        () => mockFileAClaimClient.getVehicleYears(),
      ).thenAnswer((invocation) => Future.value(testVehicleYears));
    },
    act: (cubit) => cubit.getVehicleYears(),
    expect: () => [isA<VehicleYearProcessing>(), isA<VehicleYearSuccess>()],
  );
}

final testVehicleYears = <SubmitClaimVehicleYear>[
  const SubmitClaimVehicleYear(
    key: 'test1',
    value: 'test1',
  ),
  const SubmitClaimVehicleYear(
    key: 'test2',
    value: 'test2',
  ),
  const SubmitClaimVehicleYear(
    key: 'test3',
    value: 'test3',
  ),
];
