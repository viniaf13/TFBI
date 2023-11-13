import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_response.dart';

void main() {
  ForgotPasswordVerifyResponse createObject() {
    return ForgotPasswordVerifyResponse(
      errorMessage: 'String 1',
      membershipArray: [],
      returnMessage: 'String 2',
    );
  }

  group(
    'ForgotPasswordVerifyResponse',
    () {
      test(
        'test construction',
        () async {
          final ForgotPasswordVerifyResponse obj = createObject();
          expect(obj.errorMessage, 'String 1');
          expect(obj.membershipArray, <String>[]);
          expect(obj.returnMessage, 'String 2');
        },
      );

      test(
        'test json conversion',
        () async {
          final ForgotPasswordVerifyResponse obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['ErrorMessage'], 'String 1');
          expect(map['MembershipArray'], <String>[]);
          expect(map['ReturnMessage'], 'String 2');

          final ForgotPasswordVerifyResponse newObj =
              ForgotPasswordVerifyResponse.fromJson(map);
          expect(newObj.errorMessage, 'String 1');
          expect(newObj.membershipArray, <String>[]);
          expect(newObj.returnMessage, 'String 2');
        },
      );

      test(
        'test object copying',
        () async {
          final ForgotPasswordVerifyResponse obj = createObject();
          final ForgotPasswordVerifyResponse copyObj = obj.copy();
          expect(copyObj.errorMessage, 'String 1');
          expect(copyObj.membershipArray, <String>[]);
          expect(copyObj.returnMessage, 'String 2');
        },
      );

      test(
        'test toString',
        () async {
          final ForgotPasswordVerifyResponse obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('errorMessage'), true);
          expect(str.contains('membershipArray'), true);
          expect(str.contains('returnMessage'), true);
        },
      );
    },
  ); // group
}
