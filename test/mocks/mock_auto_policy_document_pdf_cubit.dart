import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document_pdf/auto_policy_document_pdf_cubit.dart';

class MockAutoPolicyDocumentPdfCubit
    extends MockCubit<AutoPolicyDocumentPdfState>
    implements AutoPolicyDocumentPdfCubit {}

class FakeAutoPolicyDocumentPdfState extends Fake
    implements AutoPolicyDocumentPdfState {}
