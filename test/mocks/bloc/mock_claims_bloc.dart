import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';

class MockClaimsBloc extends MockBloc<ClaimsEvent, ClaimsState>
    implements ClaimsBloc {}
