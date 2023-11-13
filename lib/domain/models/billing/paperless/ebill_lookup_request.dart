// coverage:ignore-file

import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'ebill_lookup_request.g.dart';

@JsonSerializable()
class EbillLookupRequest {
  EbillLookupRequest({
    this.memberNumber,
    this.policyNumber,
    this.policyType,
  });

  factory EbillLookupRequest.fromJson(Map<String, dynamic> json) =>
      _$EbillLookupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EbillLookupRequestToJson(this);

  @JsonKey(name: 'MemberNumber')
  final String? memberNumber;
  @JsonKey(name: 'PolicyNumber')
  final String? policyNumber;
  @JsonKey(name: 'PolicyType')
  final String? policyType;

  EbillLookupRequest copyWith({
    String? memberNumber,
    String? policyNumber,
    String? policyType,
  }) =>
      EbillLookupRequest(
        memberNumber: memberNumber ?? this.memberNumber,
        policyNumber: policyNumber ?? this.policyNumber,
        policyType: policyType ?? this.policyType,
      );

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'policyNumber: $policyNumber\n';
    returnStr += 'policyType: $policyType\n';
    returnStr += 'memberNumber: $memberNumber\n';

    return returnStr;
  }
}
