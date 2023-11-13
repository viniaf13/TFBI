import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/email_verification/email_verification_response.dart';

void main() {
  EmailVerificationResponse createObject() {
    return EmailVerificationResponse(
      emailUpdate: 'String 1',
      errorMessage: 'String 2',
      returnMessage: 'String 3',
      verified: 'String 4',
    );
  }

  group(
    'EmailVerificationResponse',
    () {
      test(
        'test construction',
        () async {
          final EmailVerificationResponse obj = createObject();
          expect(obj.emailUpdate, 'String 1');
          expect(obj.errorMessage, 'String 2');
          expect(obj.returnMessage, 'String 3');
          expect(obj.verified, 'String 4');
        },
      );

      test(
        'test json conversion',
        () async {
          final EmailVerificationResponse obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['EmailUpdate'], 'String 1');
          expect(map['ErrorMessage'], 'String 2');
          expect(map['ReturnMessage'], 'String 3');
          expect(map['Verified'], 'String 4');

          final EmailVerificationResponse newObj =
              EmailVerificationResponse.fromJson(map);
          expect(newObj.emailUpdate, 'String 1');
          expect(newObj.errorMessage, 'String 2');
          expect(newObj.returnMessage, 'String 3');
          expect(newObj.verified, 'String 4');
        },
      );

      test(
        'test object copying',
        () async {
          final EmailVerificationResponse obj = createObject();
          final EmailVerificationResponse copyObj = obj.copy();
          expect(copyObj.emailUpdate, 'String 1');
          expect(copyObj.errorMessage, 'String 2');
          expect(copyObj.returnMessage, 'String 3');
          expect(copyObj.verified, 'String 4');
        },
      );

      test(
        'test toString',
        () async {
          final EmailVerificationResponse obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('emailUpdate'), true);
          expect(str.contains('errorMessage'), true);
          expect(str.contains('returnMessage'), true);
          expect(str.contains('verified'), true);
        },
      );
    },
  ); // group
}
