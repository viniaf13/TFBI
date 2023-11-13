import 'package:bloc/bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_year/vehicle_year_state.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';

class VehicleYearCubit extends Cubit<VehicleYearState> {
  VehicleYearCubit({required TfbFileClaimRepository fileClaimRepository})
      : _fileClaimRepository = fileClaimRepository,
        super(VehicleYearInitial());

  final TfbFileClaimRepository _fileClaimRepository;

  /// Returns other party vehicle makes upon user selection of Vehicle Year.
  /// OnChange value should disable Make & Model dropdowns and recall for
  /// new list data. State should NOT be reused.
  Future<void> getVehicleYears() async {
    try {
      emit(VehicleYearProcessing());

      final years = await _fileClaimRepository.getVehicleYears();

      if (years.isEmpty) {
        emit(VehicleYearFailure(error: TfbRequestError()));
      } else {
        emit(VehicleYearSuccess(years: years));
      }
    } catch (error, stack) {
      emit(
        VehicleYearFailure(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }
}
