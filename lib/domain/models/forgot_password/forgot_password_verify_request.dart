import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_verify_request.g.dart';

@JsonSerializable()
class ForgotPasswordVerifyRequest {
  ForgotPasswordVerifyRequest({
    required this.emailAddress,
    required this.verificationCode,
  });

  factory ForgotPasswordVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordVerifyRequestToJson(this);

  @JsonKey(name: 'EmailAddress')
  final String emailAddress;
  @JsonKey(name: 'VerificationCode')
  final String verificationCode;

  ForgotPasswordVerifyRequest copy() {
    return ForgotPasswordVerifyRequest(
      emailAddress: emailAddress,
      verificationCode: verificationCode,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'emailAddress: $emailAddress\n';
    returnStr += 'verificationCode: $verificationCode\n';
    return returnStr;
  }
}
