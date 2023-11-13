part of 'ebill_lookup_cubit.dart';

abstract class EbillLookUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EbillLookUpInitState extends EbillLookUpState {}

class EbillLookUpProcessingState extends EbillLookUpState {}

class EbillLookUpSuccessState extends EbillLookUpState {
  EbillLookUpSuccessState({required this.response});

  final EbillLookupResponse response;

  @override
  List<Object?> get props => [response];
}

class EbillLookUpFailureState extends EbillLookUpState {
  EbillLookUpFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}
