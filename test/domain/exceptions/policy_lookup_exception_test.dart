import 'package:test/test.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/policy_lookup_exception.dart';

void main() {
  group('PolicyLookupException', () {
    test('toString() returns the correct string representation', () {
      const errorMessage = 'Test error message';
      final exception = PolicyLookupException(errorMessage: errorMessage);

      expect(exception.toString(), 'PolicyLookupException: $errorMessage');
    });
  });
}
