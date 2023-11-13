import 'dart:convert';
import 'dart:math';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_response.dart';
import 'package:txfb_insurance_flutter/shared/constants/strings.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

class TfbUser extends HavenUser {
  TfbUser({
    required this.accessToken,
    required this.username,
    required this.agentNumber,
    required this.communicationPreferred,
    required this.emailVerified,
    required this.errorMessage,
    required this.memberName,
    required this.memberSecondaryName,
    required this.passwordResetFlag,
    required this.sessionCookie,
    required this.memberEmailAddress,
    required this.members,
  });

  factory TfbUser.fromLoginResponseAndSessionCookie(
    LoginResponse loginResponse,
    String sessionCookie,
  ) =>
      TfbUser(
        accessToken: loginResponse.accessToken!,
        username: loginResponse.username,
        agentNumber: loginResponse.agentNumber,
        communicationPreferred: loginResponse.communicationPreferred,
        emailVerified: loginResponse.emailVerified == 'True',
        errorMessage: loginResponse.errorMessage,
        memberName: loginResponse.memberName,
        memberSecondaryName: loginResponse.memberSecondaryName,
        passwordResetFlag: loginResponse.passwordResetFlag == 'True',
        memberEmailAddress: loginResponse.memberEmailAddress,
        members: loginResponse.members,
        sessionCookie: sessionCookie,
      );

  factory TfbUser.fromJson(String source) =>
      TfbUser.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TfbUser.fromMap(Map<String, dynamic> map) {
    return TfbUser(
      accessToken: map['accessToken'] as String,
      username: map['username'] as String?,
      agentNumber: map['agentNumber'] as String?,
      communicationPreferred: map['communicationPreferred'] as String?,
      emailVerified: map['emailVerified'] as bool?,
      errorMessage: map['errorMessage'] as String?,
      memberName: map['memberName'] as String?,
      memberSecondaryName: map['memberSecondaryName'] as String?,
      passwordResetFlag: map['passwordResetFlag'] as bool?,
      sessionCookie: map['sessionCookie'] as String?,
      memberEmailAddress: map['memberEmailAddress'] as String?,
      members: (map['members'] as List<dynamic>)
          .map((e) => LoginMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  TfbUser copyWith({
    String? accessToken,
    String? username,
    String? agentNumber,
    String? communicationPreferred,
    bool? emailVerified,
    String? errorMessage,
    String? memberName,
    String? memberSecondaryName,
    bool? passwordResetFlag,
    String? sessionCookie,
    String? memberEmailAddress,
    List<LoginMember>? members,
  }) {
    return TfbUser(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      agentNumber: agentNumber ?? this.agentNumber,
      communicationPreferred:
          communicationPreferred ?? this.communicationPreferred,
      emailVerified: emailVerified ?? this.emailVerified,
      errorMessage: errorMessage ?? this.errorMessage,
      memberName: memberName ?? this.memberName,
      memberSecondaryName: memberSecondaryName ?? this.memberSecondaryName,
      passwordResetFlag: passwordResetFlag ?? this.passwordResetFlag,
      sessionCookie: sessionCookie ?? this.sessionCookie,
      memberEmailAddress: memberEmailAddress ?? this.memberEmailAddress,
      members: members ?? this.members,
    );
  }

  final String accessToken;
  final String? username;
  final String? agentNumber;
  final String? communicationPreferred;
  final bool? emailVerified;
  final String? errorMessage;
  final String? memberName;
  final String? memberSecondaryName;
  final bool? passwordResetFlag;
  final String? sessionCookie;
  final String? memberEmailAddress;
  final List<LoginMember>? members;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'username': username,
      'agentNumber': agentNumber,
      'communicationPreferred': communicationPreferred,
      'emailVerified': emailVerified,
      'errorMessage': errorMessage,
      'memberName': memberName,
      'memberSecondaryName': memberSecondaryName,
      'passwordResetFlag': passwordResetFlag,
      'memberEmailAddress': memberEmailAddress,
      'sessionCookie': sessionCookie,
      'members': members,
    };
  }

  String toJson() => json.encode(toMap());

  String get getFirstName => memberName?.split(' ').firstOrNull ?? '';

  @override
  String toString() {
    return 'TxUser(accessToken: ${accessToken.substring(0, min(32, accessToken.length))}, username: $username, agentNumber: $agentNumber, communicationPreferred: $communicationPreferred, emailVerified: $emailVerified, errorMessage: $errorMessage, memberName: $memberName, memberSecondaryName: $memberSecondaryName, passwordResetFlag: $passwordResetFlag, sessionCookie: $sessionCookie, memberEmailAddress: $memberEmailAddress)';
  }

  TfbUser copy() {
    return TfbUser(
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
      sessionCookie: sessionCookie,
      members: members,
    );
  }

  @visibleForTesting
  String decodeBase64(String toDecode) {
    String localToDecode = toDecode;
    String res;
    try {
      while (localToDecode.length * 6 % 8 != 0) {
        localToDecode += '=';
      }
      res = utf8.decode(base64.decode(localToDecode));
    } catch (error) {
      throw Exception(
        'decodeBase64([toDecode=$localToDecode]) \n\t\terror: $error',
      );
    }
    return res;
  }

  /// Returns true if Token is expired, otherwise false
  bool isTokenExpired() {
    try {
      final String token = accessToken;
      final parts = token.split(kSplitAtPeriod);
      if (token == 'testAccessToken') return true;
      if (parts.length != 3) {
        throw ArgumentError(kInvalidTokenFormat);
      } else {
        final payloadString = decodeBase64(parts[1]);
        final payload = jsonDecode(payloadString);

        final expiryTime = DateTime.fromMillisecondsSinceEpoch(
          (payload[kPayloadExp] as int) * 1000,
        );
        final currentTime = DateTime.now();

        return currentTime.isAfter(expiryTime);
      }
    } catch (e, stack) {
      TfbLogger.warning(
        'Error occurred while checking if user token is expired',
        e,
        stack,
      );
      return true;
    }
  }
}
