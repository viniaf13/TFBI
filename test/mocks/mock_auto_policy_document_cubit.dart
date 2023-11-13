import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document/auto_policy_document_cubit.dart';

class MockAutoPolicyDocumentCubit extends MockCubit<AutoPolicyDocumentState>
    implements AutoPolicyDocumentCubit {}

class FakeAutoPolicyDocumentState extends Fake
    implements AutoPolicyDocumentState {}
