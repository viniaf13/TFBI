// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'login_member.g.dart';

@JsonSerializable()
class LoginMember {
  LoginMember({
    required this.lastLoginTimestamp,
    required this.memberIDNumber,
    required this.memberNumber,
  });

  factory LoginMember.fromJson(Map<String, dynamic> json) =>
      _$LoginMemberFromJson(json);

  Map<String, dynamic> toJson() => _$LoginMemberToJson(this);

  @JsonKey(name: 'LastLoginTimestamp')
  final String lastLoginTimestamp;
  @JsonKey(name: 'MemberIDNumber')
  final int memberIDNumber;
  @JsonKey(name: 'MemberNumber')
  final String memberNumber;

  LoginMember copy() {
    return LoginMember(
      lastLoginTimestamp: lastLoginTimestamp,
      memberIDNumber: memberIDNumber,
      memberNumber: memberNumber,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'lastLoginTimestamp: $lastLoginTimestamp\n';
    returnStr += 'memberIDNumber: $memberIDNumber\n';
    returnStr += 'memberNumber: $memberNumber\n';
    return returnStr;
  }
}
