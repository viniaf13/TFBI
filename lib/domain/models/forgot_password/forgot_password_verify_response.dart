import 'package:json_annotation/json_annotation.dart';

// Note: May need more imports for custom data types!

part 'forgot_password_verify_response.g.dart';

@JsonSerializable()
class ForgotPasswordVerifyResponse {
  ForgotPasswordVerifyResponse({
    this.errorMessage,
    this.membershipArray,
    this.returnMessage,
  });

  factory ForgotPasswordVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordVerifyResponseToJson(this);

  @JsonKey(name: 'ErrorMessage')
  final String? errorMessage;
  @JsonKey(name: 'MembershipArray')
  final List<String>? membershipArray;
  @JsonKey(name: 'ReturnMessage')
  final String? returnMessage;

  ForgotPasswordVerifyResponse copy() {
    return ForgotPasswordVerifyResponse(
      errorMessage: errorMessage,
      membershipArray:
          membershipArray != null ? List.from(membershipArray!) : null,
      returnMessage: returnMessage,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr +=
        'errorMessage: ${errorMessage != null ? '$errorMessage' : 'null'}\n';
    returnStr +=
        'membershipArray: ${membershipArray != null ? '$membershipArray' : 'null'}\n';
    returnStr +=
        'returnMessage: ${returnMessage != null ? '$returnMessage' : 'null'}\n';
    return returnStr;
  }
}
