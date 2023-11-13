import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';

class MockAutoPayBloc extends MockBloc<AutopayEvent, AutopayState>
    implements AutopayBloc {}

final mockAutopayDiscontinueSuccess = AutopayDiscontinueSuccess();

final mockAutopayCancelled = AutopayCancelled();

final mockAutopayInitial = AutopayInitial();
