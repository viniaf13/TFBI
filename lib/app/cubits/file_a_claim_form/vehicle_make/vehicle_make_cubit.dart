import 'package:bloc/bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_make/vehicle_make_state.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';

class VehicleMakeCubit extends Cubit<VehicleMakeState> {
  VehicleMakeCubit({required TfbFileClaimRepository fileClaimRepository})
      : _fileClaimRepository = fileClaimRepository,
        super(VehicleMakeInitial());

  final TfbFileClaimRepository _fileClaimRepository;

  /// Returns other party vehicle makes upon user selection of Vehicle Year.
  /// OnChange value should disable Make & Model dropdowns and recall for
  /// new list data. State should NOT be reused.
  Future<void> getVehicleMakes(String year) async {
    try {
      emit(VehicleMakeProcessing());

      final makes = await _fileClaimRepository.getVehicleMakes(year);

      if (makes.isEmpty) {
        emit(VehicleMakeFailure(error: TfbRequestError()));
      } else {
        emit(VehicleMakeSuccess(makes: makes));
      }
    } catch (error, stack) {
      emit(
        VehicleMakeFailure(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }
}
