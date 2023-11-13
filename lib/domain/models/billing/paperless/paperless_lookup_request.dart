// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
part 'paperless_lookup_request.g.dart';

@JsonSerializable()
class PaperlessLookupRequest {
  PaperlessLookupRequest({
    this.memberNumber,
    this.policyNumber,
    this.policyType,
  });

  factory PaperlessLookupRequest.fromJson(Map<String, dynamic> json) =>
      _$PaperlessLookupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PaperlessLookupRequestToJson(this);

  @JsonKey(name: 'MemberNumber')
  final String? memberNumber;
  @JsonKey(name: 'PolicyNumber')
  final String? policyNumber;
  @JsonKey(name: 'PolicyType')
  final String? policyType;

  PaperlessLookupRequest copyWith({
    String? memberNumber,
    String? policyNumber,
    String? policyType,
  }) =>
      PaperlessLookupRequest(
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
