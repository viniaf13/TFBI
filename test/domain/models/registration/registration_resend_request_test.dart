import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';

void main() {
  RegistrationResendRequest createObject() {
    return RegistrationResendRequest(
      communicationOption: 'String 1',
      emailAddress: 'String 2',
      memberNumber: 'String 3',
      password: 'String 4',
      policyNumber: 'String 5',
    );
  }

  group(
    'RegistrationResendRequest',
    () {
      test(
        'test construction',
        () async {
          final RegistrationResendRequest obj = createObject();
          expect(obj.communicationOption, 'String 1');
          expect(obj.emailAddress, 'String 2');
          expect(obj.memberNumber, 'String 3');
          expect(obj.password, 'String 4');
          expect(obj.policyNumber, 'String 5');
        },
      );

      test(
        'test json conversion',
        () async {
          final RegistrationResendRequest obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['CommunicationOption'], 'String 1');
          expect(map['EmailAddress'], 'String 2');
          expect(map['MemberNumber'], 'String 3');
          expect(map['Password'], 'String 4');
          expect(map['PolicyNumber'], 'String 5');

          final RegistrationResendRequest newObj =
              RegistrationResendRequest.fromJson(map);
          expect(newObj.communicationOption, 'String 1');
          expect(newObj.emailAddress, 'String 2');
          expect(newObj.memberNumber, 'String 3');
          expect(newObj.password, 'String 4');
          expect(newObj.policyNumber, 'String 5');
        },
      );

      test(
        'test object copying',
        () async {
          final RegistrationResendRequest obj = createObject();
          final RegistrationResendRequest copyObj = obj.copy();
          expect(copyObj.communicationOption, 'String 1');
          expect(copyObj.emailAddress, 'String 2');
          expect(copyObj.memberNumber, 'String 3');
          expect(copyObj.password, 'String 4');
          expect(copyObj.policyNumber, 'String 5');
        },
      );

      test(
        'test toString',
        () async {
          final RegistrationResendRequest obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('communicationOption'), true);
          expect(str.contains('emailAddress'), true);
          expect(str.contains('memberNumber'), true);
          expect(str.contains('password'), true);
          expect(str.contains('policyNumber'), true);
        },
      );
    },
  ); // group
}
