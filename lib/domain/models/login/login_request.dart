import 'package:json_annotation/json_annotation.dart';
import 'package:txfb_insurance_flutter/data/network/constants/tfb_network_constants.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  LoginRequest({
    required this.password,
    required this.username,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  /// Override the toJson method so that the only time the google recaptcha
  /// token is exposed is when the login request is sent.
  ///
  /// This means we'll have to update this method manually in the future, but I
  /// doubt this will change.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Password': password,
        'Username': username,
        'GoogleCaptchaToken': kDefaultGoogleRecaptchaToken.value,
      };

  @JsonKey(name: 'Password')
  final String password;
  @JsonKey(name: 'Username')
  final String username;

  LoginRequest copy() {
    return LoginRequest(
      password: password,
      username: username,
    );
  }

  @override
  String toString() {
    String returnStr = '';
    returnStr += 'password: $password\n';
    returnStr += 'username: $username\n';
    return returnStr;
  }
}
