import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_authentication_client.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auth_repository.dart';

import 'mock_tfb_auth_client.dart';

class MockTfbAuthenticationRepository extends Mock
    implements TfbAuthRepository {
  @override
  Future<void> init() async {}

  @override
  bool get isSignedIn => false;

  @override
  TfbAuthenticationClient get authClient => MockTfbAuthClient();
}
