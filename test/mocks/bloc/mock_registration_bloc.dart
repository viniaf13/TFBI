import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/blocs/registration/registration_bloc.dart';

class MockRegistrationBloc
    extends MockBloc<RegistrationEvent, RegistrationState>
    implements RegistrationBloc {}
