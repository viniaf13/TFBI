import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/save_image_exception.dart';

void main() {
  test('InsufficientSpaceException should have correct message', () {
    const message = 'Not enough space available';

    final exception = InsufficientSpaceException(
      message: message,
    );

    expect(exception.message, message);
  });

  test(
      'InsufficientSpaceException toString() should return the '
      'correct format', () {
    const message = 'Not enough space available';

    final exception = InsufficientSpaceException(
      message: message,
    );
    final result = exception.toString();

    expect(result, 'InsufficientSpaceException: $message');
  });
}
