import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_state.dart';

class MockVehicleMakeCubit extends MockCubit<VehicleMakeState>
    implements VehicleMakeCubit {}
