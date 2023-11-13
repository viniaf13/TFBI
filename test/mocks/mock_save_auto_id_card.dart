import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';

class MockSaveAutoIdCardCubit extends MockCubit<SaveAutoIdCardState>
    implements SaveAutoIdCardCubit {}

class FakeSaveAutoIdCardState extends Fake implements SaveAutoIdCardState {}
