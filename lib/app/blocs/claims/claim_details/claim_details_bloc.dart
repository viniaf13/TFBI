import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';

part 'claim_details_event.dart';
part 'claim_details_state.dart';

class ClaimDetailsBloc extends Bloc<ClaimDetailsEvent, ClaimDetailsState> {
  ClaimDetailsBloc({required this.claimsRepo})
      : super(ClaimDetailsInitState()) {
    on<GetClaimDetailsEvent>(_getClaimDetails);
  }

  final TfbClaimsClientRepository claimsRepo;

  Future<void> _getClaimDetails(
    GetClaimDetailsEvent event,
    Emitter<ClaimDetailsState> emit,
  ) async {
    try {
      emit(FetchClaimDetailsProcessingState());
      emit(
        FetchClaimDetailsSuccess(
          claim: await claimsRepo.getClaimDetails(
            event.claimNumber,
            event.policyNumber,
          ),
        ),
      );
    } catch (error, stack) {
      emit(
        FetchClaimDetailsFailure(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }
}
