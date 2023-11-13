part of 'claim_details_bloc.dart';

abstract class ClaimDetailsState extends Equatable {}

class ClaimDetailsInitState extends ClaimDetailsState {
  @override
  List<Object?> get props => [];
}

//States for fetching claims details
class FetchClaimDetailsProcessingState extends ClaimDetailsState {
  @override
  List<Object?> get props => [];
}

class FetchClaimDetailsFailure extends ClaimDetailsState {
  FetchClaimDetailsFailure({required this.error});

  final TfbRequestError? error;

  @override
  List<Object?> get props => [error];
}

class FetchClaimDetailsSuccess extends ClaimDetailsState {
  FetchClaimDetailsSuccess({required this.claim});

  final ClaimDetails? claim;

  @override
  List<Object?> get props => [claim];
}
