import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_loss_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_make.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_year.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/claim_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/policy_details/policy_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_county.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_phone_types.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_types.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

class MockFileAClaimClient extends Mock implements FileAClaimClient {}

class MockTfbDocumentInformationClient extends Mock
    implements TfbDocumentInformationClient {}

class MockTfbPolicyLookupRepository extends Mock
    implements TfbPolicyLookupRepository {}

void main() {
  group('TfbFileClaimRepository', () {
    late TfbFileClaimRepository repository;
    late MockFileAClaimClient mockFileAClaimClient;
    late MockTfbDocumentInformationClient mockTfbDocumentInformationClient;
    late MockTfbPolicyLookupRepository mockTfbPolicyLookupRepository;
    final mockAutoPolicy = AutoPolicyDetail(
      policyType: '',
      policySubType: '',
      policySymbol: '',
      policyAddress: Address(
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ),
      policyBilling: PolicyBilling(
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        [],
        '',
        '',
        '',
      ),
      policyNumber: '',
      policyDescription: '',
      effectiveDate: '',
      expirationDate: '',
    );

    setUp(() {
      mockFileAClaimClient = MockFileAClaimClient();
      mockTfbDocumentInformationClient = MockTfbDocumentInformationClient();
      mockTfbPolicyLookupRepository = MockTfbPolicyLookupRepository();
      repository = TfbFileClaimRepository(
        fileClaimClient: mockFileAClaimClient,
        documentClient: mockTfbDocumentInformationClient,
        policyLookUp: mockTfbPolicyLookupRepository,
      );
    });

    test('fetchTexasCounties', () async {
      final List<SubmitClaimCounty> expectedCounties = [];
      when(() => mockFileAClaimClient.fetchTexasCounties())
          .thenAnswer((_) async => expectedCounties);

      expect(await repository.fetchTexasCounties(), expectedCounties);
      verify(() => mockFileAClaimClient.fetchTexasCounties()).called(1);
    });

    test('getFormData', () async {
      final AutoPolicyDetail expectedAutoPolicyDetail = mockAutoPolicy;
      final List<SubmitClaimPhoneTypes> expectedPhoneTypes = [];
      final List<SubmitClaimReporterTypes> expectedReporterTypes = [];
      final List<SubmitClaimAutoLossTypes> expectedAutoLossTypes = [];
      final List<SubmitClaimCounty> expectedCounties = [];
      final List<SubmitClaimVehicleYear?> expectedVehicleYears = [];
      final PolicyDetails expectedPolicyDetails = PolicyDetails();
      const String policyNumber = '12345';
      const String policySymbol = 'PA1';
      const String claimDate = '2023-01-01';

      when(
        () => mockTfbDocumentInformationClient
            .getPersonalSixMonthAutoPolicyAbbreviated(policyNumber),
      ).thenAnswer((_) async => expectedAutoPolicyDetail);
      when(() => mockFileAClaimClient.fetchPhoneTypes())
          .thenAnswer((_) async => expectedPhoneTypes);
      when(() => mockFileAClaimClient.fetchReporterTypes())
          .thenAnswer((_) async => expectedReporterTypes);
      when(() => mockFileAClaimClient.fetchAutoLossTypes())
          .thenAnswer((_) async => expectedAutoLossTypes);
      when(() => mockFileAClaimClient.fetchTexasCounties())
          .thenAnswer((_) async => expectedCounties);
      when(() => mockFileAClaimClient.getVehicleYears())
          .thenAnswer((_) async => expectedVehicleYears);
      when(
        () => mockFileAClaimClient.getPolicyDetails(
          policyNumber,
          policySymbol,
          claimDate,
        ),
      ).thenAnswer((_) async => expectedPolicyDetails);

      final ClaimFormData formData = await repository.getFormData(
        policyNumber,
        policySymbol: policySymbol,
        claimDate: claimDate,
        isAutoClaim: true,
      );

      verify(
        () => mockTfbDocumentInformationClient
            .getPersonalSixMonthAutoPolicyAbbreviated(policyNumber),
      ).called(1);
      verify(() => mockFileAClaimClient.fetchPhoneTypes()).called(1);
      verify(() => mockFileAClaimClient.fetchReporterTypes()).called(1);
      verify(() => mockFileAClaimClient.fetchAutoLossTypes()).called(1);
      verify(() => mockFileAClaimClient.fetchTexasCounties()).called(1);
      verify(() => mockFileAClaimClient.getVehicleYears()).called(1);
      verify(
        () => mockFileAClaimClient.getPolicyDetails(
          policyNumber,
          policySymbol,
          claimDate,
        ),
      ).called(1);

      expect(formData.contactType, expectedPhoneTypes);
      expect(formData.reporterType, expectedReporterTypes);
      expect(formData.typeOfLoss, expectedAutoLossTypes);
      expect(formData.county, expectedCounties);
      expect(formData.vehicleYears, expectedVehicleYears);
      expect(formData.policyDetails, expectedPolicyDetails);
    });

    test('fetchPhoneTypes', () async {
      final List<SubmitClaimPhoneTypes> expectedPhoneTypes = [];
      when(() => mockFileAClaimClient.fetchPhoneTypes())
          .thenAnswer((_) async => expectedPhoneTypes);

      expect(await repository.fetchPhoneTypes(), expectedPhoneTypes);
      verify(() => mockFileAClaimClient.fetchPhoneTypes()).called(1);
    });

    test('fetchReporterTypes', () async {
      final List<SubmitClaimReporterTypes> expectedReporterTypes = [];
      when(() => mockFileAClaimClient.fetchReporterTypes())
          .thenAnswer((_) async => expectedReporterTypes);

      expect(await repository.fetchReporterTypes(), expectedReporterTypes);
      verify(() => mockFileAClaimClient.fetchReporterTypes()).called(1);
    });

    test('fetchAutoLossTypes', () async {
      final List<SubmitClaimAutoLossTypes> expectedAutoLossTypes = [];
      when(() => mockFileAClaimClient.fetchAutoLossTypes())
          .thenAnswer((_) async => expectedAutoLossTypes);

      expect(await repository.fetchAutoLossTypes(), expectedAutoLossTypes);
      verify(() => mockFileAClaimClient.fetchAutoLossTypes()).called(1);
    });

    test('getVehicleYears', () async {
      final List<SubmitClaimVehicleYear?> expectedVehicleYears = [];
      when(() => mockFileAClaimClient.getVehicleYears())
          .thenAnswer((_) async => expectedVehicleYears);

      expect(await repository.getVehicleYears(), expectedVehicleYears);
      verify(() => mockFileAClaimClient.getVehicleYears()).called(1);
    });

    test('getVehicleMakes', () async {
      final List<SubmitClaimVehicleMake?> expectedVehicleMakes = [];
      const String year = '2023';

      when(() => mockFileAClaimClient.getVehicleMakes(year))
          .thenAnswer((_) async => expectedVehicleMakes);

      expect(await repository.getVehicleMakes(year), expectedVehicleMakes);
      verify(() => mockFileAClaimClient.getVehicleMakes(year)).called(1);
    });

    test('getVehicleModels', () async {
      final List<VehicleModelResponse> expectedVehicleModels = [];
      const VehicleModelRequest request = VehicleModelRequest(
        year: '2023',
        make: 'ACURA',
      );

      when(() => mockFileAClaimClient.getVehicleModels(request))
          .thenAnswer((_) async => expectedVehicleModels);

      expect(await repository.getVehicleModels(request), expectedVehicleModels);
      verify(() => mockFileAClaimClient.getVehicleModels(request)).called(1);
    });
  });
}
