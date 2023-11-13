import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/clients/policy_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary_response.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../../mocks/mock_policy_lookup_client.dart';

class MockTfbPolicyLookupClient extends Mock implements TfbPolicyLookupClient {
  @override
  Future<MemberSummaryResponse> getMemberSummary(String token) async {
    return MemberSummaryResponse(
      policies: [
        MockPolicy.createPolicySummary(policyNumber: '1'),
        MockPolicy.createPolicySummary(policyNumber: '2'),
      ],
    );
  }

  @override
  Future<HomeownerPolicyDetail> getHomeownersPolicy(
    String policyNum,
    String policyType,
    String policySubtype,
    String accessToken,
  ) async {
    return MockPolicy.createHomeownerPolicyDetail(policyNum: policyNum);
  }

  @override
  Future<AutoPolicyDetail> getPersonalAutoPolicy(
    String policyNumber,
    String accessToken,
  ) async {
    return MockPolicy.createAutoPolicyDetail();
  }
}

void main() {
  final mockClient = MockTfbPolicyLookupClient();
  late TfbPolicyLookupRepository repo;

  setUp(() {
    repo = TfbPolicyLookupRepository(
      client: mockClient,
      accessToken: '',
    );
  });

  test('Policy Lookup Repo invokes Policy Lookup Client for member summary',
      () async {
    final response = await repo.getMemberSummary();
    expect(response.policies.length, 2);
  });

  test('getPersonalAutoPolicy retrieves an auto policy', () async {
    final policySummary =
        MockPolicy.createPolicySummary(policyType: PolicyType.txPersonalAuto);
    final result = await repo.getPersonalAutoPolicy(policySummary);
    expect(result, isA<AutoPolicyDetail>());
  });

  test(
      'Get policy details invokes homeowner client detail API for homeowner types',
      () async {
    final member = await repo.getMemberSummary();
    final details = await repo.getPolicyDetails(member.policies);
    final keys = details.keys;
    expect(details.length, 2);
    expect(details[keys.first], isA<HomeownerPolicyDetail>());
    expect(details[keys.last], isA<HomeownerPolicyDetail>());
  });

  test('getPolicyDetails retrieves details for homeowner polies', () async {
    final member = await repo.getMemberSummary();
    final details = await repo.getPolicyDetails(member.policies);
    expect(details.values, anyElement(isA<HomeownerPolicyDetail>()));
  });
}
