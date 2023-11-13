// coverage:ignore-file

import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_base.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

class ClaimSubmission {
  ClaimSubmission({
    required this.policyType,
    required this.claimFormAnswers,
    required this.policySelection,
    required this.dateOfLoss,
  });

  final PolicyType policyType;
  final SubmitClaimBase claimFormAnswers;
  final PolicySelection policySelection;
  final String dateOfLoss;
}
