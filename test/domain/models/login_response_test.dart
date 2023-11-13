import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login.dart';

void main() {
  LoginResponse createObject() {
    return LoginResponse(
      accessToken: 'String 1',
      agentNumber: 'String 2',
      communicationPreferred: 'String 3',
      emailVerified: 'String 4',
      errorMessage: 'String 5',
      memberEmailAddress: 'String 6',
      memberName: 'String 7',
      memberSecondaryName: 'String 8',
      passwordResetFlag: 'String 9',
      username: 'String 10',
    );
  }

  group(
    'LoginResponse',
    () {
      test(
        'test construction',
        () async {
          final LoginResponse obj = createObject();
          expect(obj.accessToken, 'String 1');
          expect(obj.agentNumber, 'String 2');
          expect(obj.communicationPreferred, 'String 3');
          expect(obj.emailVerified, 'String 4');
          expect(obj.errorMessage, 'String 5');
          expect(obj.memberEmailAddress, 'String 6');
          expect(obj.memberName, 'String 7');
          expect(obj.memberSecondaryName, 'String 8');
          expect(obj.passwordResetFlag, 'String 9');
          expect(obj.username, 'String 10');
        },
      );

      test(
        'test json conversion',
        () async {
          final LoginResponse obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['AccessToken'], 'String 1');
          expect(map['AgentNumber'], 'String 2');
          expect(map['CommunicationPreferred'], 'String 3');
          expect(map['EmailVerified'], 'String 4');
          expect(map['ErrorMessage'], 'String 5');
          expect(map['MemberEmailAddress'], 'String 6');
          expect(map['MemberName'], 'String 7');
          expect(map['MemberSecondaryName'], 'String 8');
          expect(map['PasswordResetFlag'], 'String 9');
          expect(map['UserName'], 'String 10');

          final LoginResponse newObj = LoginResponse.fromJson(map);
          expect(newObj.accessToken, 'String 1');
          expect(newObj.agentNumber, 'String 2');
          expect(newObj.communicationPreferred, 'String 3');
          expect(newObj.emailVerified, 'String 4');
          expect(newObj.errorMessage, 'String 5');
          expect(newObj.memberEmailAddress, 'String 6');
          expect(newObj.memberName, 'String 7');
          expect(newObj.memberSecondaryName, 'String 8');
          expect(newObj.passwordResetFlag, 'String 9');
          expect(newObj.username, 'String 10');
        },
      );

      test(
        'test object copying',
        () async {
          final LoginResponse obj = createObject();
          final LoginResponse copyObj = obj.copy();
          expect(copyObj.accessToken, 'String 1');
          expect(copyObj.agentNumber, 'String 2');
          expect(copyObj.communicationPreferred, 'String 3');
          expect(copyObj.emailVerified, 'String 4');
          expect(copyObj.errorMessage, 'String 5');
          expect(copyObj.memberEmailAddress, 'String 6');
          expect(copyObj.memberName, 'String 7');
          expect(copyObj.memberSecondaryName, 'String 8');
          expect(copyObj.passwordResetFlag, 'String 9');
          expect(copyObj.username, 'String 10');
        },
      );

      test(
        'test toString',
        () async {
          final LoginResponse obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('accessToken'), true);
          expect(str.contains('agentNumber'), true);
          expect(str.contains('communicationPreferred'), true);
          expect(str.contains('emailVerified'), true);
          expect(str.contains('errorMessage'), true);
          expect(str.contains('memberEmailAddress'), true);
          expect(str.contains('memberName'), true);
          expect(str.contains('memberSecondaryName'), true);
          expect(str.contains('passwordResetFlag'), true);
          expect(str.contains('userName'), true);
        },
      );
    },
  ); // group
}
