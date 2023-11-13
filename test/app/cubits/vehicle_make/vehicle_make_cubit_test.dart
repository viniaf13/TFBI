import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_state.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
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

    registerFallbackValue(mockYear);
  });

  test('VehicleMakeCubit should start in the VehicleMakeInitial state', () {
    expect(
      VehicleMakeCubit(
        fileClaimRepository: TfbFileClaimRepository(
          fileClaimClient: mockFileAClaimClient,
          documentClient: MockTfbDocumentInformationClient(),
          policyLookUp: MockTfbPolicyLookupRepository(),
        ),
      ).state,
      isA<VehicleMakeInitial>(),
    );
  });

  blocTest<VehicleMakeCubit, VehicleMakeState>(
    'If getVehicleMakes call fails, state should be a VehicleMakeFailure',
    build: () => VehicleMakeCubit(
      fileClaimRepository: TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: MockTfbDocumentInformationClient(),
        policyLookUp: MockTfbPolicyLookupRepository(),
      ),
    ),
    setUp: () {
      when(
        () => mockFileAClaimClient.getVehicleMakes(any()),
      ).thenThrow(Exception('ERROR'));
    },
    act: (cubit) => cubit.getVehicleMakes(mockYear),
    expect: () => [isA<VehicleMakeProcessing>(), isA<VehicleMakeFailure>()],
  );

  blocTest<VehicleMakeCubit, VehicleMakeState>(
    'If getVehicleMakes call succeeds, state should be a VehicleMakeSuccess',
    build: () => VehicleMakeCubit(
      fileClaimRepository: TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: MockTfbDocumentInformationClient(),
        policyLookUp: MockTfbPolicyLookupRepository(),
      ),
    ),
    setUp: () {
      when(
        () => mockFileAClaimClient.getVehicleMakes(any()),
      ).thenAnswer((invocation) => Future.value(testVehicleMakes));
    },
    act: (cubit) => cubit.getVehicleMakes(mockYear),
    expect: () => [isA<VehicleMakeProcessing>(), isA<VehicleMakeSuccess>()],
  );
}

const mockYear = '2023';

final testVehicleMakes = <SubmitClaimVehicleMake>[
  const SubmitClaimVehicleMake(
    key: 'test1',
    value: 'test1',
  ),
  const SubmitClaimVehicleMake(
    key: 'test2',
    value: 'test2',
  ),
  const SubmitClaimVehicleMake(
    key: 'test3',
    value: 'test3',
  ),
];
