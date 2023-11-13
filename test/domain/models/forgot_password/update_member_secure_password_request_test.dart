import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/update_member_secure_password_request.dart';

void main() {
  UpdateMemberSecurePasswordRequest createObject() {
    return UpdateMemberSecurePasswordRequest(
      memberId: 1,
      membershipArray: [],
      newPassword: 'String 1',
      userName: 'String 2',
    );
  }

  group(
    'UpdateMemberSecurePasswordRequest',
    () {
      test(
        'test construction',
        () async {
          final UpdateMemberSecurePasswordRequest obj = createObject();
          expect(obj.memberId, 1);
          expect(obj.membershipArray, <String>[]);
          expect(obj.newPassword, 'String 1');
          expect(obj.userName, 'String 2');
        },
      );

      test(
        'test json conversion',
        () async {
          final UpdateMemberSecurePasswordRequest obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['MemberId'], 1);
          expect(map['MembershipArray'], <String>[]);
          expect(map['NewPassword'], 'String 1');
          expect(map['UserName'], 'String 2');

          final UpdateMemberSecurePasswordRequest newObj =
              UpdateMemberSecurePasswordRequest.fromJson(map);
          expect(newObj.memberId, 1);
          expect(newObj.membershipArray, <String>[]);
          expect(newObj.newPassword, 'String 1');
          expect(newObj.userName, 'String 2');
        },
      );

      test(
        'test object copying',
        () async {
          final UpdateMemberSecurePasswordRequest obj = createObject();
          final UpdateMemberSecurePasswordRequest copyObj = obj.copy();
          expect(copyObj.memberId, 1);
          expect(copyObj.membershipArray, <String>[]);
          expect(copyObj.newPassword, 'String 1');
          expect(copyObj.userName, 'String 2');
        },
      );

      test(
        'test toString',
        () async {
          final UpdateMemberSecurePasswordRequest obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('memberId'), true);
          expect(str.contains('membershipArray'), true);
          expect(str.contains('newPassword'), true);
          expect(str.contains('userName'), true);
        },
      );
    },
  );
}
