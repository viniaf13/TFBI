import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class MockDioError extends Mock implements DioException {
  @override
  String? message = 'DIO_ERROR';

  static String defaultMessage = 'DIO_ERROR';
}
