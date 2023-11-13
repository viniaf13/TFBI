import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/login/tfb_user.dart';

void main() {
  const expiredToken =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6IjYxNjU3NTJEMjFBN0YyNjM3OTU5MjBCNEM5NDY4NUE2RUE0MzZBNzUiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJZV1YxTFNHbjhtTjVXU0MweVVhRnB1cERhblUifQ.eyJuYmYiOjE2ODI0NDczNTAsImV4cCI6MTY4Mzc0MzM1MCwiaXNzIjoiaHR0cHM6Ly9zc29zdGcudHhmYi1pbnMuY29tIiwiYXVkIjpbImh0dHBzOi8vc3Nvc3RnLnR4ZmItaW5zLmNvbS9yZXNvdXJjZXMiLCJ0ZmJfc3NvX2FwaSJdLCJjbGllbnRfaWQiOiJyby5jbGllbnQiLCJzdWIiOiIxMjIxNTIiLCJhdXRoX3RpbWUiOjE2ODI0NDczNTAsImlkcCI6ImxvY2FsIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiYm90dGxlcm9ja2V0QHR4ZmJpbnMuY29tIiwiZW1haWwiOiJib3R0bGVyb2NrZXRAdHhmYmlucy5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicGFzc3dvcmRfZmxhZyI6ZmFsc2UsImluc3VyZWRfaWQiOjEyMjE1MiwibWVtYmVyX2xpc3QiOiIxMjIxNTItU0pMTC00LzI1LzIwMjMgMToyOToxMCBQTTsiLCJjdXJyZW50X21lbWJlciI6IlNKTEwiLCJjb21tdW5pY2F0aW9uX2ZsYWciOmZhbHNlLCJuYW1lIjoiYm90dGxlcm9ja2V0QHR4ZmJpbnMuY29tIiwic2NvcGUiOlsiZW1haWwiLCJvcGVuaWQiLCJwcm9maWxlIiwidGZiX3Nzb19hcGkiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.W2cyKwQ_VfajibZEH2tAWeddZycE9XJBgYYoNaIWogyGrKUmtbQ1ASSj9Qar_cuvHav8V7iMM4PuBxrzEv00709DU1HI86oQSn6AH-FNWfEyXu_rCyaoZxsrG8JuFs4I9s6gWC9pgOtE0JIfna8jmYynn2KNFeHtTNoWVTO0--wIUKdk3xAebMvNv-kW1Ai0ZTrlPke8xx9xP50V3zWnKcCVwhGUuQo34X5cvFHFPBdy26k12kO54Rtt6OjtLPkg4rnL4WTjphVi6H04YqLB3WxClh-';

  TfbUser createObject() {
    return TfbUser(
      accessToken: expiredToken,
      agentNumber: 'String 2',
      communicationPreferred: 'String 3',
      emailVerified: true,
      errorMessage: 'String 4',
      memberEmailAddress: 'String 5',
      memberName: 'String 6',
      memberSecondaryName: 'String 7',
      passwordResetFlag: false,
      username: 'String 8',
      sessionCookie: 'String 9',
      members: const [],
    );
  }

  group(
    'TfbUser',
    () {
      test(
        'test construction',
        () async {
          final TfbUser obj = createObject();
          expect(obj.accessToken, expiredToken);
          expect(obj.agentNumber, 'String 2');
          expect(obj.communicationPreferred, 'String 3');
          expect(obj.emailVerified, true);
          expect(obj.errorMessage, 'String 4');
          expect(obj.memberEmailAddress, 'String 5');
          expect(obj.memberName, 'String 6');
          expect(obj.memberSecondaryName, 'String 7');
          expect(obj.passwordResetFlag, false);
          expect(obj.username, 'String 8');
          expect(obj.sessionCookie, 'String 9');
        },
      );

      test(
        'test json conversion',
        () async {
          final TfbUser obj = createObject();
          final map = obj.toMap();
          expect(map.isNotEmpty, true);
          expect(map['accessToken'], expiredToken);
          expect(map['agentNumber'], 'String 2');
          expect(map['communicationPreferred'], 'String 3');
          expect(map['emailVerified'], true);
          expect(map['errorMessage'], 'String 4');
          expect(map['memberEmailAddress'], 'String 5');
          expect(map['memberName'], 'String 6');
          expect(map['memberSecondaryName'], 'String 7');
          expect(map['passwordResetFlag'], false);
          expect(map['username'], 'String 8');
          expect(map['sessionCookie'], 'String 9');

          final TfbUser newObj = TfbUser.fromJson(obj.toJson());
          expect(newObj.accessToken, expiredToken);
          expect(newObj.agentNumber, 'String 2');
          expect(newObj.communicationPreferred, 'String 3');
          expect(newObj.emailVerified, true);
          expect(newObj.errorMessage, 'String 4');
          expect(newObj.memberEmailAddress, 'String 5');
          expect(newObj.memberName, 'String 6');
          expect(newObj.memberSecondaryName, 'String 7');
          expect(newObj.passwordResetFlag, false);
          expect(newObj.username, 'String 8');
          expect(newObj.sessionCookie, 'String 9');
        },
      );

      test(
        'test object copying',
        () async {
          final TfbUser obj = createObject();
          final TfbUser copyObj = obj.copy();
          expect(copyObj.accessToken, expiredToken);
          expect(copyObj.agentNumber, 'String 2');
          expect(copyObj.communicationPreferred, 'String 3');
          expect(copyObj.emailVerified, true);
          expect(copyObj.errorMessage, 'String 4');
          expect(copyObj.memberEmailAddress, 'String 5');
          expect(copyObj.memberName, 'String 6');
          expect(copyObj.memberSecondaryName, 'String 7');
          expect(copyObj.passwordResetFlag, false);
          expect(copyObj.username, 'String 8');
          expect(copyObj.sessionCookie, 'String 9');
        },
      );

      test(
        'test toString',
        () async {
          final TfbUser obj = createObject();
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
          expect(str.contains('username'), true);
          expect(str.contains('sessionCookie'), true);
        },
      );

      test('isTokenExpired returns true when token is expired', () {
        final TfbUser obj = createObject();
        final bool result = obj.isTokenExpired();
        expect(result, true);
      });

      test('_decodeBase64 correctly decodes a base64 string', () {
        final TfbUser obj = createObject();
        const input = 'SGVsbG8gd29ybGQ=';
        const expectedOutput = 'Hello world';
        expect(obj.decodeBase64(input), equals(expectedOutput));
      });

      test('_decodeBase64 throws an exception for invalid input', () {
        final TfbUser obj = createObject();
        const invalidInput = 'invalid base64 string';
        expect(() => obj.decodeBase64(invalidInput), throwsA(isA<Exception>()));
      });

      test('test method getFirstName with membername', () {
        final TfbUser obj = createObject();
        expect(obj.getFirstName, 'String');
      });

      test('test method getFirstName without membername', () {
        final Map<String, dynamic> map = {
          'accessToken': '',
          'membername': '',
          'members': [
            {
              'MemberNumber': '1',
              'MemberIDNumber': 1,
              'LastLoginTimestamp': '',
            },
          ],
        };

        final TfbUser newObj = TfbUser.fromMap(map);
        expect(newObj.getFirstName, '');
      });

      test('test method getFirstName without username in json null', () {
        final Map<String, dynamic> map = {
          'accessToken': '',
          'members': [
            {
              'MemberNumber': '1',
              'MemberIDNumber': 1,
              'LastLoginTimestamp': '',
            },
          ],
        };

        final TfbUser newObj = TfbUser.fromMap(map);
        expect(newObj.getFirstName, '');
      });
    },
  );
}
