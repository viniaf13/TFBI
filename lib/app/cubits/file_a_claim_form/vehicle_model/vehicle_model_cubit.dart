import 'package:bloc/bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/file_a_claim_form/vehicle_model/vehicle_model_state.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_vehicle_model.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';

class VehicleModelCubit extends Cubit<VehicleModelState> {
  VehicleModelCubit({required TfbFileClaimRepository fileClaimRepository})
      : _fileClaimRepository = fileClaimRepository,
        super(VehicleModelInitial());

  final TfbFileClaimRepository _fileClaimRepository;

  /// Returns other party vehicle models upon user selection of Vehicle Make.
  /// OnChange value should disable Make & Model dropdowns and recall for
  /// new list data. State should NOT be reused.
  Future<void> getVehicleModels(VehicleModelRequest request) async {
    try {
      emit(VehicleModelProcessing());
      final models = await _fileClaimRepository.getVehicleModels(request);

      if (models.isEmpty) {
        emit(VehicleModelFailure(error: TfbRequestError()));
      } else {
        emit(VehicleModelSuccess(models: models));
      }
    } catch (error, stack) {
      emit(
        VehicleModelFailure(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }
}
