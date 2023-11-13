part of 'paperless_lookup_cubit.dart';

abstract class PaperlessLookupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaperlessLookupInitState extends PaperlessLookupState {}

class PaperlessLookupProcessingState extends PaperlessLookupState {}

/// Response has an error message field for server side errors
class PaperlessLookupSuccessState extends PaperlessLookupState {
  PaperlessLookupSuccessState({required this.response});

  final PaperlessLookupResponse response;

  @override
  List<Object?> get props => [response];
}

class PaperlessLookupFailureState extends PaperlessLookupState {
  PaperlessLookupFailureState({required this.error});

  final TfbRequestError error;

  @override
  List<Object?> get props => [error];
}
