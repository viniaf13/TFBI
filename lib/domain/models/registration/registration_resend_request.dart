// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router_query_params.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';

// Note: May need more imports for custom data types!

part 'registration_resend_request.g.dart';

@JsonSerializable()
class RegistrationResendRequest {
  RegistrationResendRequest({
    required this.communicationOption,
    required this.emailAddress,
    required this.memberNumber,
    required this.password,
    required this.policyNumber,
  });

  factory RegistrationResendRequest.fromQueryParams(Map<String, String> json) {
    return RegistrationResendRequest(
      communicationOption:
          json[TfbRouterQueryParams.communicationQueryKey] ?? '',
      emailAddress: json[TfbRouterQueryParams.emailQueryKey] ?? '',
      memberNumber: json[TfbRouterQueryParams.memberNumberKey] ?? '',
      password: json[TfbRouterQueryParams.passwordKey] ?? '',
      policyNumber: json[TfbRouterQueryParams.policyNumberKey] ?? '',
    );
  }

  factory RegistrationResendRequest.fromRegistrationRequest(
    RegistrationRequest request,
  ) {
    // Resend doesn't need communication option or password, but the property
    // keys still have to be on the request, just empty strings.
    return RegistrationResendRequest(
      communicationOption: '',
      emailAddress: request.emailAddress,
      memberNumber: request.memberNumber,
      password: '',
      policyNumber: request.policyNumber,
    );
  }

  factory RegistrationResendRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResendRequestToJson(this);

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

  RegistrationResendRequest copy() {
    return RegistrationResendRequest(
      communicationOption: communicationOption,
      emailAddress: emailAddress,
      memberNumber: memberNumber,
      password: password,
      policyNumber: policyNumber,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'communicationOption: $communicationOption\n';
    returnStr += 'emailAddress: $emailAddress\n';
    returnStr += 'memberNumber: $memberNumber\n';
    returnStr += 'password: $password\n';
    returnStr += 'policyNumber: $policyNumber\n';
    return returnStr;
  }
}
