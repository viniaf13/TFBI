import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';

class MixinTestClass with PagePropertiesMixin {
  @override
  String get screenName => 'Test Screen';
}

void main() {
  test('PagePropertiesMixin should return correct screen name', () {
    final testClass = MixinTestClass();

    final result = testClass.screenName;

    expect(result, 'Test Screen');
  });
}
