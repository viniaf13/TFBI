// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'delete_account_request.g.dart';

@JsonSerializable()
class DeleteAccountRequest {
  DeleteAccountRequest({
    required this.memberId,
    required this.memberInitials,
    required this.memberNumber,
  });

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);

  @JsonKey(name: 'MemberId')
  final int memberId;
  @JsonKey(name: 'MemberInitials')
  final String memberInitials;
  @JsonKey(name: 'MemberNumber')
  final String memberNumber;

  DeleteAccountRequest copy() {
    return DeleteAccountRequest(
      memberId: memberId,
      memberInitials: memberInitials,
      memberNumber: memberNumber,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'memberId: $memberId\n';
    returnStr += 'memberInitials: $memberInitials\n';
    returnStr += 'memberNumber: $memberNumber\n';
    return returnStr;
  }
}
