import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_request.dart';

void main() {
  LoginRequest createObject() {
    return LoginRequest(
      password: 'String 1',
      username: 'String 2',
    );
  }

  group(
    'LoginRequest',
    () {
      test(
        'test construction',
        () async {
          final LoginRequest obj = createObject();
          expect(obj.password, 'String 1');
          expect(obj.username, 'String 2');
        },
      );

      test(
        'test json conversion',
        () async {
          final LoginRequest obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['Password'], 'String 1');
          expect(map['Username'], 'String 2');

          final LoginRequest newObj = LoginRequest.fromJson(map);
          expect(newObj.password, 'String 1');
          expect(newObj.username, 'String 2');
        },
      );

      test(
        'test object copying',
        () async {
          final LoginRequest obj = createObject();
          final LoginRequest copyObj = obj.copy();
          expect(copyObj.password, 'String 1');
          expect(copyObj.username, 'String 2');
        },
      );

      test(
        'test toString',
        () async {
          final LoginRequest obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('password'), true);
          expect(str.contains('username'), true);
        },
      );
    },
  );
}
