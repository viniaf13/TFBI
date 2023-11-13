import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.agentNumber,
    this.communicationPreferred,
    this.emailVerified,
    this.errorMessage,
    this.memberEmailAddress,
    this.memberName,
    this.memberSecondaryName,
    this.passwordResetFlag,
    this.username,
    this.members,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  factory LoginResponse.fromJsonAndCookie(
    Map<String, dynamic> json,
    String cookie,
  ) {
    final LoginResponse response = _$LoginResponseFromJson(json)
      ..sessionCookies = cookie;
    return response;
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @JsonKey(name: 'AccessToken')
  final String? accessToken;
  @JsonKey(name: 'AgentNumber')
  final String? agentNumber;
  @JsonKey(name: 'CommunicationPreferred')
  final String? communicationPreferred;
  @JsonKey(name: 'EmailVerified')
  final String? emailVerified;
  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;
  @JsonKey(name: 'MemberEmailAddress')
  final String? memberEmailAddress;
  @JsonKey(name: 'Members')
  final List<LoginMember>? members;
  @JsonKey(name: 'MemberName')
  final String? memberName;
  @JsonKey(name: 'MemberSecondaryName')
  final String? memberSecondaryName;
  @JsonKey(name: 'PasswordResetFlag')
  final String? passwordResetFlag;
  @JsonKey(name: 'UserName')
  final String? username;

  /// The value of the set-cookie header in the login response
  String? sessionCookies;

  LoginResponse copy() {
    return LoginResponse(
      accessToken: accessToken,
      agentNumber: agentNumber,
      communicationPreferred: communicationPreferred,
      emailVerified: emailVerified,
      errorMessage: errorMessage,
      memberEmailAddress: memberEmailAddress,
      memberName: memberName,
      memberSecondaryName: memberSecondaryName,
      passwordResetFlag: passwordResetFlag,
      username: username,
      members: members,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr +=
        'accessToken: ${accessToken != null ? '$accessToken' : 'null'}\n';
    returnStr +=
        'agentNumber: ${agentNumber != null ? '$agentNumber' : 'null'}\n';
    returnStr +=
        'communicationPreferred: ${communicationPreferred != null ? '$communicationPreferred' : 'null'}\n';
    returnStr +=
        'emailVerified: ${emailVerified != null ? '$emailVerified' : 'null'}\n';
    returnStr +=
        'errorMessage: ${errorMessage != null ? '$errorMessage' : 'null'}\n';
    returnStr +=
        'memberEmailAddress: ${memberEmailAddress != null ? '$memberEmailAddress' : 'null'}\n';
    returnStr += 'memberName: ${memberName != null ? '$memberName' : 'null'}\n';
    returnStr +=
        'memberSecondaryName: ${memberSecondaryName != null ? '$memberSecondaryName' : 'null'}\n';
    returnStr +=
        'passwordResetFlag: ${passwordResetFlag != null ? '$passwordResetFlag' : 'null'}\n';
    returnStr += 'userName: ${username != null ? '$username' : 'null'}\n';
    returnStr += 'members: ${members != null ? '$members' : 'null'}\n';
    return returnStr;
  }
}
