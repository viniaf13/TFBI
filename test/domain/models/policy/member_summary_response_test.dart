import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

import '../../../mocks/mock_policy_lookup_client.dart';

void main() {
  final policySummaryList = [
    MockPolicy.createPolicySummary(),
    MockPolicy.createPolicySummary(),
  ];
  group('MemberSummaryResponse', () {
    test('fromJson should correctly initialize MemberSummaryResponse object',
        () {
      final json = {
        'Policies': <List<PolicySummary>>[],
        'ErrorMessage': 'Error message',
      };

      final response = MemberSummaryResponse.fromJson(json);

      expect(response.policies, <List<PolicySummary>>[]);
      expect(response.errorMessage, 'Error message');
    });

    test('toJson should return a valid JSON map', () {
      final response = MemberSummaryResponse(
        policies: policySummaryList,
        errorMessage: 'Error message',
      );

      final json = response.toJson();

      expect(json['Policies'], policySummaryList);
      expect(json['ErrorMessage'], 'Error message');
    });

    test('convertToMemberSummary should return a MemberSummary object', () {
      final response = MemberSummaryResponse(policies: policySummaryList);

      final memberSummary = response.convertToMemberSummary();

      expect(memberSummary.policies, policySummaryList);
    });

    test('toString should return a formatted string representation', () {
      final response = MemberSummaryResponse(
        policies: policySummaryList,
        errorMessage: 'Error message',
      );

      final result = response.toString();

      expect(result, contains('policies: $policySummaryList'));
      expect(result, contains('errorMessage: Error message'));
    });
  });
}
