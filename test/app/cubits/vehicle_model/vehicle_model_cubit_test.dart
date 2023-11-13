import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_state.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
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

    registerFallbackValue(mockRequest);
  });

  test('VehicleModelCubit should start in the VehicleModelInitial state', () {
    expect(
      VehicleModelCubit(
        fileClaimRepository: TfbFileClaimRepository(
          fileClaimClient: mockFileAClaimClient,
          documentClient: MockTfbDocumentInformationClient(),
          policyLookUp: MockTfbPolicyLookupRepository(),
        ),
      ).state,
      isA<VehicleModelInitial>(),
    );
  });

  blocTest<VehicleModelCubit, VehicleModelState>(
    'If getVehicleModels call fails, state should be a VehicleModelFailure',
    build: () => VehicleModelCubit(
      fileClaimRepository: TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: MockTfbDocumentInformationClient(),
        policyLookUp: MockTfbPolicyLookupRepository(),
      ),
    ),
    setUp: () {
      when(
        () => mockFileAClaimClient.getVehicleModels(any()),
      ).thenThrow(Exception('ERROR'));
    },
    act: (cubit) => cubit.getVehicleModels(mockRequest),
    expect: () => [isA<VehicleModelProcessing>(), isA<VehicleModelFailure>()],
  );

  blocTest<VehicleModelCubit, VehicleModelState>(
    'If getVehicleModels call succeeds, state should be a VehicleModelSuccess',
    build: () => VehicleModelCubit(
      fileClaimRepository: TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: MockTfbDocumentInformationClient(),
        policyLookUp: MockTfbPolicyLookupRepository(),
      ),
    ),
    setUp: () {
      when(
        () => mockFileAClaimClient.getVehicleModels(any()),
      ).thenAnswer((invocation) => Future.value(testVehicleModels));
    },
    act: (cubit) => cubit.getVehicleModels(mockRequest),
    expect: () => [isA<VehicleModelProcessing>(), isA<VehicleModelSuccess>()],
  );
}

const mockRequest = VehicleModelRequest(
  year: '2023',
  make: 'ACURA',
);

final testVehicleModels = <VehicleModelResponse>[
  VehicleModelResponse(
    key: 'test1',
    value: 'test1',
  ),
  VehicleModelResponse(
    key: 'test2',
    value: 'test2',
  ),
  VehicleModelResponse(
    key: 'test3',
    value: 'test3',
  ),
];
