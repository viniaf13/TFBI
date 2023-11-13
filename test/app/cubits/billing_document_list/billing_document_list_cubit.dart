import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_list/billing_document_list_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';

class MockBillingDocumentListCubit extends MockCubit<TfbSingleRequestState>
    implements BillingDocumentListCubit {}
