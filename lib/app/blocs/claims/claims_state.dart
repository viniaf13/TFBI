part of 'claims_bloc.dart';

abstract class ClaimsState extends Equatable {}

class ClaimsInitState extends ClaimsState {
  @override
  List<Object?> get props => [];
}

class ClaimsProcessingState extends ClaimsState {
  ClaimsProcessingState({required this.isPullToRefresh});

  final bool isPullToRefresh;

  @override
  List<Object?> get props => [isPullToRefresh];
}

class ClaimsFailureState extends ClaimsState {
  ClaimsFailureState({
    required this.error,
  });

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}

class ClaimSuccessState extends ClaimsState {
  ClaimSuccessState({required this.fullClaimsList});

  final List<FullClaim?> fullClaimsList;

  int openClaims(String policyNumber) {
    return activeClaims
        .where(
          (claim) => claim.policyNumber == policyNumber,
        )
        .length;
  }

  @override
  List<Object?> get props => [fullClaimsList];

  List<FullClaim> get activeClaims {
    final claimsList = fullClaimsList
        .where(
          (claim) =>
              claim != null &&
              claim.isActive() &&
              (claim.policyType == PolicyType.homeowners ||
                  claim.policyType == PolicyType.txPersonalAuto),
        )
        .toList();

    return claimsList as List<FullClaim>;
  }
}
