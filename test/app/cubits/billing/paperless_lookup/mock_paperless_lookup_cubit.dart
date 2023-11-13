import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';

class MockPaperlessLookupCubit extends MockCubit<PaperlessLookupState>
    implements PaperlessLookupCubit {}

class FakePaperlessLookupState extends Fake implements PaperlessLookupState {}
