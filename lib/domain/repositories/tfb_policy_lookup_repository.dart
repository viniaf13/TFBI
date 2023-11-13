import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:txfb_insurance_flutter/domain/clients/policy_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/policy_lookup_exception.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_submission_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary_response.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

// TODO: Look into if we can integrate the access token directly into the client
// instead of relying on a repository wrapper
class TfbPolicyLookupRepository {
  TfbPolicyLookupRepository({
    required TfbPolicyLookupClient client,
    required String accessToken,
  })  : _client = client,
        _accessToken = accessToken;

  final TfbPolicyLookupClient _client;
  final String _accessToken;
  final Map<String, PolicyDetail> _policyMap = {};

  Future<MemberSummary> getMemberSummary() async {
    // Repo is re-created upon new authentication, so we cache value for
    // current user instance.
    MemberSummaryResponse? memberSummaryResponse;

    memberSummaryResponse = await _client.getMemberSummary(_accessToken);

    if (memberSummaryResponse.errorMessage?.isNotEmpty ?? false) {
      throw PolicyLookupException(
        errorMessage: memberSummaryResponse.errorMessage!,
      );
    }

    return memberSummaryResponse.convertToMemberSummary();
  }

  Future<Map<String, PolicyDetail>> getPolicyDetails(
    List<PolicySummary> policies,
  ) async {
    final List<TfbRequestError> errors = [];
    for (final PolicySummary policy in policies) {
      try {
        if (policy.policyType == PolicyType.homeowners) {
          final htPolicy = await getHomeownersPolicy(policy);
          if (htPolicy != null) {
            _policyMap[htPolicy.policyNumber] = htPolicy;
          }
        } else if (policy.policyType == PolicyType.txPersonalAuto) {
          final autoPolicy = await getPersonalAutoPolicy(policy);
          if (autoPolicy != null) {
            _policyMap[autoPolicy.policyNumber] = autoPolicy;
          }
        } else if (policy.policyType == PolicyType.agAdvantage) {
          final farmPolicy = await getAgAdvantagePolicy(policy);
          if (farmPolicy != null) {
            _policyMap[farmPolicy.policyNumber] = farmPolicy;
          }
        } else {
          debugPrint('Ignoring policy type ${policy.policyDescription}');
        }
      } catch (e, stack) {
        final error = TfbRequestError.fromObject(e, stack: stack);
        TfbLogger.exception(
          'Get policy detail call failed with error:',
          error,
          stack,
        );
        errors.add(error);
      }
    }
    if (errors.isNotEmpty) {
      final errorResponse = (errors.first, _policyMap);
      throw errorResponse;
    }
    return _policyMap;
  }

  Future<HomeownerPolicyDetail?> getHomeownersPolicy(
    PolicySummary policy,
  ) async {
    return _client.getHomeownersPolicy(
      policy.policyNumber,
      policy.policyType.value,
      policy.policySubType,
      _accessToken,
    );
  }

  Future<AutoPolicyDetail?> getPersonalAutoPolicy(PolicySummary policy) async {
    return _client.getPersonalAutoPolicy(
      policy.policyNumber,
      _accessToken,
    );
  }

  Future<AgAdvantagePolicyDetail?> getAgAdvantagePolicy(
    PolicySummary policy,
  ) async =>
      _client.getAgAdvantagePolicy(
        policy.policyNumber,
        policy.policyType.value,
        policy.policySubType,
      );

  Future<PaperlessLookupResponse> fetchPaperlessAccountDetails(
    PaperlessLookupRequest request,
  ) async =>
      _client.fetchPaperlessAccountDetails(request);

  Future<EbillLookupResponse> fetchEbillNotificationDetails(
    PolicySummary policy,
  ) async =>
      _client.fetchEbillNotificationDetails(
        EbillLookupRequest(
          memberNumber: policy.memberNumber,
          policyNumber: policy.policyNumber,
          policyType: policy.policyType.value,
        ),
      );

  Future<String> validateRoutingNumber(
    String routingNumber,
  ) async {
    final response = jsonDecode(
      await _client.validateRoutingNumber(routingNumber) ?? '',
    ).toString();

    return response.isEmpty || response == '""'
        ? ''
        : response.replaceAll('"', '').trim();
  }

  Future<bool> updateAutopayConfiguration(
    AutopaySubmissionRequest request,
  ) =>
      _client.autopayEnrollment(request);
}
