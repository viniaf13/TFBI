import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_request.dart';

void main() {
  ForgotPasswordVerifyRequest createObject() {
    return ForgotPasswordVerifyRequest(
      emailAddress: 'String 1',
      verificationCode: 'String 2',
    );
  }

  group(
    'ForgotPasswordVerifyRequest',
    () {
      test(
        'test construction',
        () async {
          final ForgotPasswordVerifyRequest obj = createObject();
          expect(obj.emailAddress, 'String 1');
          expect(obj.verificationCode, 'String 2');
        },
      );

      test(
        'test json conversion',
        () async {
          final ForgotPasswordVerifyRequest obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['EmailAddress'], 'String 1');
          expect(map['VerificationCode'], 'String 2');

          final ForgotPasswordVerifyRequest newObj =
              ForgotPasswordVerifyRequest.fromJson(map);
          expect(newObj.emailAddress, 'String 1');
          expect(newObj.verificationCode, 'String 2');
        },
      );

      test(
        'test object copying',
        () async {
          final ForgotPasswordVerifyRequest obj = createObject();
          final ForgotPasswordVerifyRequest copyObj = obj.copy();
          expect(copyObj.emailAddress, 'String 1');
          expect(copyObj.verificationCode, 'String 2');
        },
      );

      test(
        'test toString',
        () async {
          final ForgotPasswordVerifyRequest obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('emailAddress'), true);
          expect(str.contains('verificationCode'), true);
        },
      );
    },
  );
}
