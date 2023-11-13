import 'package:bloc_test/bloc_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_state.dart';

class MockModelVehicleCubit extends MockCubit<VehicleModelState>
    implements VehicleModelCubit {}
