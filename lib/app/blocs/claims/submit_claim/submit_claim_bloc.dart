import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/auto_claim/submit_claim_auto_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/property_claim/submit_claim_property_response.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/claim_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';

part 'submit_claim_event.dart';
part 'submit_claim_state.dart';

class SubmitClaimBloc extends Bloc<SubmitClaimEvent, SubmitClaimState> {
  SubmitClaimBloc({required this.fileClaimRepo})
      : super(SubmitClaimInitState()) {
    on<SubmitClaimGetPolicyListEvent>(_getListOfPolicies);
    on<ClaimFormInitEvent>(_initClaimForm);
    on<SubmitPropertyClaimEvent>(_submitPropertyClaim);
    on<SubmitAutoClaimEvent>(_submitAutoClaim);
  }

  final TfbFileClaimRepository fileClaimRepo;

  /// Returns a list of PolicySelections for File A Claim policy list
  /// dropdown menu. Use display text for dropdown item
  Future<void> _getListOfPolicies(
    SubmitClaimGetPolicyListEvent event,
    Emitter<SubmitClaimState> emit,
  ) async {
    emit(SubmitClaimProcessingState());
    final policies = await fileClaimRepo.getPolicySelections();

    policies.isEmpty
        ? emit(SubmitClaimPolicyListFailureState(error: TfbRequestError()))
        : emit(SubmitClaimPolicyListSuccessState(policies: policies));
  }

  /// Returns initial data needed to build lists for File A Claim Form
  /// dropdown menus. Many of these fields could be populated with static
  /// Enum data, if needed. OnChange value should disable Make & Model
  /// dropdowns and recall for new list data; state should NOT be reused.
  /// VehicleYear, use key to create a vehicle model request and the value for
  /// UI display to account for "1981": "Prior to 1982"
  Future<void> _initClaimForm(
    ClaimFormInitEvent event,
    Emitter<SubmitClaimState> emit,
  ) async {
    try {
      emit(SubmitClaimProcessingState());
      emit(
        SubmitClaimFormInitSuccess(
          claimFormData: await fileClaimRepo.getFormData(
            event.selectedPolicy.policyNumber,
            policySymbol: event.selectedPolicy.policySymbol,
            claimDate: event.dateOfLoss,
            isAutoClaim:
                event.selectedPolicy.policyType == PolicyType.txPersonalAuto,
          ),
        ),
      );
    } catch (error, stack) {
      emit(
        SubmitClaimFormInitFailure(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }

  Future<void> _submitPropertyClaim(
    SubmitPropertyClaimEvent event,
    Emitter<SubmitClaimState> emit,
  ) async {
    try {
      emit(SubmitPropertyClaimProcessingState());

      emit(
        SubmitPropertyClaimSuccessState(
          data: await fileClaimRepo.filePropertyClaim(
            event.propertyClaimSubmission,
          ),
        ),
      );
    } catch (error, stack) {
      emit(
        SubmitPropertyClaimFailureState(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }

  Future<void> _submitAutoClaim(
    SubmitAutoClaimEvent event,
    Emitter<SubmitClaimState> emit,
  ) async {
    try {
      emit(SubmitAutoClaimProcessingState());

      emit(
        SubmitAutoClaimSuccessState(
          data: await fileClaimRepo.fileAutoClaim(
            event.autoClaimSubmission,
          ),
        ),
      );
    } catch (error, stack) {
      emit(
        SubmitAutoClaimFailureState(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }
}
