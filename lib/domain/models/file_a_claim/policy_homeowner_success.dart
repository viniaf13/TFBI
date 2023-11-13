// coverage:ignore-file

import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_info.dart';

class PolicyHomeownerSuccess extends PolicyInfo {
  PolicyHomeownerSuccess({
    required this.confirmationNumber,
    required super.policySelection,
    required super.dateOfLoss,
  });
  final String confirmationNumber;
}
