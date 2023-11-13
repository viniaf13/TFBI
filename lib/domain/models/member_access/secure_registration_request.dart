// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';

part 'secure_registration_request.g.dart';

@JsonSerializable()
class RegistrationRequest {
  RegistrationRequest({
    required this.communicationOption,
    required this.emailAddress,
    required this.memberNumber,
    required this.password,
    required this.policyNumber,
  });

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);

  @JsonKey(name: 'CommunicationOption')
  final String communicationOption;
  @JsonKey(name: 'EmailAddress')
  final String emailAddress;
  @JsonKey(name: 'MemberNumber')
  final String memberNumber;
  @JsonKey(name: 'Password')
  final String password;
  @JsonKey(name: 'PolicyNumber')
  final String policyNumber;
}
