import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';

class MockTfbNavigator extends Mock implements TfbNavigator {
  @override
  String get currentRelativePath => '';
}
