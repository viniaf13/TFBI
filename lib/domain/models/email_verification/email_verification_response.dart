import 'package:json_annotation/json_annotation.dart';

part 'email_verification_response.g.dart';

@JsonSerializable()
class EmailVerificationResponse {
  EmailVerificationResponse({
    required this.emailUpdate,
    required this.errorMessage,
    required this.returnMessage,
    required this.verified,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailVerificationResponseToJson(this);

  @JsonKey(name: 'EmailUpdate')
  final String emailUpdate;
  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;
  @JsonKey(name: 'ReturnMessage')
  final String returnMessage;
  @JsonKey(name: 'Verified')
  final String verified;

  EmailVerificationResponse copy() {
    return EmailVerificationResponse(
      emailUpdate: emailUpdate,
      errorMessage: errorMessage,
      returnMessage: returnMessage,
      verified: verified,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'emailUpdate: $emailUpdate\n';
    returnStr += 'errorMessage: $errorMessage\n';
    returnStr += 'returnMessage: $returnMessage\n';
    returnStr += 'verified: $verified\n';
    return returnStr;
  }
}
