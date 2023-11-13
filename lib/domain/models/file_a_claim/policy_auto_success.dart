//  Copyright © 2023 Bottle Rocket Studios. All rights reserved.
// coverage:ignore-file

import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_info.dart';

class PolicyAutoSuccess extends PolicyInfo {
  PolicyAutoSuccess({
    required this.claimNumber,
    required super.policySelection,
    required super.dateOfLoss,
  });
  final String claimNumber;
}
