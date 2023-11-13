import 'package:json_annotation/json_annotation.dart';

part 'update_member_secure_password_request.g.dart';

@JsonSerializable()
class UpdateMemberSecurePasswordRequest {
  UpdateMemberSecurePasswordRequest({
    required this.memberId,
    required this.membershipArray,
    required this.newPassword,
    required this.userName,
  });

  factory UpdateMemberSecurePasswordRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UpdateMemberSecurePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateMemberSecurePasswordRequestToJson(this);

  @JsonKey(name: 'MemberId')
  final int memberId;
  @JsonKey(name: 'MembershipArray')
  final List<String> membershipArray;
  @JsonKey(name: 'NewPassword')
  final String newPassword;
  @JsonKey(name: 'UserName')
  final String userName;

  UpdateMemberSecurePasswordRequest copy() {
    return UpdateMemberSecurePasswordRequest(
      memberId: memberId,
      membershipArray: List.from(membershipArray),
      newPassword: newPassword,
      userName: userName,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'memberId: $memberId\n';
    returnStr += 'membershipArray: $membershipArray\n';
    returnStr += 'newPassword: $newPassword\n';
    returnStr += 'userName: $userName\n';
    return returnStr;
  }
}
