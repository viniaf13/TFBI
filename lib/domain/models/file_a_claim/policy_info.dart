// coverage:ignore-file

import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';

class PolicyInfo {
  PolicyInfo({
    required this.policySelection,
    required this.dateOfLoss,
  });

  final PolicySelection policySelection;
  final String dateOfLoss;
}
