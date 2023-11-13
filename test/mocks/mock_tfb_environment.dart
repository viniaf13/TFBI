import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';

class MockTfbEnvironment extends Mock implements TfbEnvironment {
  @override
  String get apiUrl => 'https://www.fake-url.com';
}
