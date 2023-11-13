// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'user_information.g.dart';

@JsonSerializable()
class UserInformation {
  UserInformation({
    required this.accountCreateDate,
    required this.communicationOption,
    required this.emailAddress,
    required this.emailVerificationIndicator,
    required this.insuredId,
    required this.lastLoginDate,
    required this.memberNumber,
    required this.passwordResetIndicator,
    required this.pendingEmailChange,
    required this.userName,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);

  Map<String, dynamic> toJson() => _$UserInformationToJson(this);

  @JsonKey(name: 'AccountCreateDate')
  final String accountCreateDate;
  @JsonKey(name: 'CommunicationOption')
  final String communicationOption;
  @JsonKey(name: 'EmailAddress')
  final String emailAddress;
  @JsonKey(name: 'EmailVerificationIndicator')
  final String emailVerificationIndicator;
  @JsonKey(name: 'InsuredId')
  final int insuredId;
  @JsonKey(name: 'LastLoginDate')
  final String lastLoginDate;
  @JsonKey(name: 'MemberNumber')
  final String memberNumber;
  @JsonKey(name: 'PasswordResetIndicator')
  final String passwordResetIndicator;
  @JsonKey(name: 'PendingEmailChange')
  final String pendingEmailChange;
  @JsonKey(name: 'UserName')
  final String userName;
}
