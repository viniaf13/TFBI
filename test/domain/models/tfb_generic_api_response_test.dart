import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

void main() {
  TfbGenericApiResponse createObject() {
    return TfbGenericApiResponse(
      errorMessage: 'String 1',
      returnMessage: 'String 2',
    );
  }

  group(
    'TfbGenericApiResponse',
    () {
      test(
        'test construction',
        () async {
          final TfbGenericApiResponse obj = createObject();
          expect(obj.errorMessage, 'String 1');
          expect(obj.returnMessage, 'String 2');
        },
      );

      test(
        'test json conversion',
        () async {
          final TfbGenericApiResponse obj = createObject();
          final map = obj.toJson();
          expect(map.isNotEmpty, true);
          expect(map['ErrorMessage'], 'String 1');
          expect(map['ReturnMessage'], 'String 2');

          final TfbGenericApiResponse newObj =
              TfbGenericApiResponse.fromJson(map);
          expect(newObj.errorMessage, 'String 1');
          expect(newObj.returnMessage, 'String 2');
        },
      );

      test(
        'test object copying',
        () async {
          final TfbGenericApiResponse obj = createObject();
          final TfbGenericApiResponse copyObj = obj.copy();
          expect(copyObj.errorMessage, 'String 1');
          expect(copyObj.returnMessage, 'String 2');
        },
      );

      test(
        'test toString',
        () async {
          final TfbGenericApiResponse obj = createObject();
          final String str = obj.toString();
          expect(str.isNotEmpty, true);
          expect(str.contains('errorMessage'), true);
          expect(str.contains('returnMessage'), true);
        },
      );
    },
  ); // group
}
