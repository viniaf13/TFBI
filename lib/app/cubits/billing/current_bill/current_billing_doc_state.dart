part of 'current_billing_doc_cubit.dart';

abstract class CurrentBillingDocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentBillingDocInitState extends CurrentBillingDocState {}

class CurrentBillingDocProcessingState extends CurrentBillingDocState {}

class CurrentBillingDocSuccessState extends CurrentBillingDocState {
  CurrentBillingDocSuccessState({required this.filePath});

  final String filePath;

  @override
  List<Object?> get props => [filePath];
}

class CurrentBillingDocFailureState extends CurrentBillingDocState {
  CurrentBillingDocFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}
