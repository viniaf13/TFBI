import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/claims_extensions.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'claims_event.dart';
part 'claims_state.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  ClaimsBloc({required this.claimsRepository}) : super(ClaimsInitState()) {
    on<ClaimsInitEvent>(_getAllClaims);
  }

  final TfbClaimsClientRepository claimsRepository;

  Future<void> _getAllClaims(
    ClaimsInitEvent event,
    Emitter<ClaimsState> emit,
  ) async {
    try {
      emit(ClaimsProcessingState(isPullToRefresh: event.isPullToRefresh));

      /// Call to get list of claims
      final response =
          await claimsRepository.getAllMemberClaims(event.memberNumber)
            ..claims?.forEach(
              (claim) => TfbLogger.info('Claim:\n${claim.toString()}'),
            );

      /// Call to get claim details; [_getClaimDetails] returns the state we emit
      if (response.claims == null) {
        emit(ClaimSuccessState(fullClaimsList: const <FullClaim>[]));
        return;
      }
      emit(await _getClaimDetails(response.claims!));
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);

      TfbLogger.exception(
        '[getAllMemberClaims] Failure:\nError: $error\nStack: $stack',
      );

      emit(ClaimsFailureState(error: error));
    }
  }

  /// Calls to get claim details and create a FullClaim with all information
  Future<ClaimsState> _getClaimDetails(
    List<Claim> claimsList,
  ) async {
    try {
      final List<FullClaim> fullClaims = [];
      for (final claim in claimsList) {
        if (claim.policyType?.value == PolicyType.homeowners.value ||
            claim.policyType?.value == PolicyType.txPersonalAuto.value) {
          final response = await claimsRepository.getClaimDetails(
            claim.claimNumber!,
            claim.policyNumber!,
          );
          if (response != null) {
            final fullClaim = claim.toFullClaim(response);
            TfbLogger.info(
              '[getClaimDetails] Full Claim Details:\n${fullClaim.toString()}',
            );
            fullClaims.add(fullClaim);
          }
        }
      }
      return ClaimSuccessState(fullClaimsList: fullClaims);
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);

      TfbLogger.exception(
        '[getClaimDetails] Failure:\nError: $error\nStack: $stack',
      );

      return ClaimsFailureState(error: error);
    }
  }
}
