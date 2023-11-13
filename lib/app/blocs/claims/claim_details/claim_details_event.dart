part of 'claim_details_bloc.dart';

abstract class ClaimDetailsEvent {}

class ClaimsInitEvent extends ClaimDetailsEvent {}

//A claim has been filed and the details are requested
class GetClaimDetailsEvent extends ClaimDetailsEvent {
  GetClaimDetailsEvent({
    required this.policyNumber,
    required this.claimNumber,
  });

  final String policyNumber;
  final String claimNumber;
}
