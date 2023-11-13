import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/clients/claims_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claim_details/claim_details.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims_list/claims_list.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';

class MockClaimsClient extends Mock implements ClaimsClient {}

void main() {
  group('TfbClaimsClientRepository', () {
    late MockClaimsClient mockClaimsClient;
    late TfbClaimsClientRepository tfbClaimsClientRepository;

    setUp(() {
      mockClaimsClient = MockClaimsClient();
      tfbClaimsClientRepository = TfbClaimsClientRepository(
        client: mockClaimsClient,
      );
    });

    test('getAllMemberClaims calls ClaimsClient with correct parameters',
        () async {
      when(
        () => mockClaimsClient.getAllMemberNumberClaims(
          any(),
        ),
      ).thenAnswer((_) async => Future.value(ClaimsList()));

      await tfbClaimsClientRepository.getAllMemberClaims('test_member');

      verify(() => mockClaimsClient.getAllMemberNumberClaims('test_member'))
          .called(1);
    });

    test('getAllPolicyClaims calls ClaimsClient with correct parameters',
        () async {
      when(
        () => mockClaimsClient.getAllPolicyNumberClaims(
          any(),
        ),
      ).thenAnswer((_) async => Future.value(ClaimsList()));

      await tfbClaimsClientRepository.getAllPolicyClaims('test_policy');

      verify(() => mockClaimsClient.getAllPolicyNumberClaims('test_policy'))
          .called(1);
    });

    test('getClaimDetails calls ClaimsClient with correct parameters',
        () async {
      when(
        () => mockClaimsClient.getClaimDetails(
          any(),
          any(),
        ),
      ).thenAnswer((_) async => Future.value(ClaimDetails()));

      await tfbClaimsClientRepository.getClaimDetails(
        'test_claim',
        'test_policy',
      );

      verify(
        () => mockClaimsClient.getClaimDetails(
          'test_claim',
          'test_policy',
        ),
      ).called(1);
    });
  });
}
