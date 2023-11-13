import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_email/update_email_cubit.dart';

class MockUpdateEmailCubit extends MockCubit<TfbSingleRequestState>
    implements UpdateEmailCubit {}
