part of 'tfb_single_request_cubit.dart';

sealed class TfbSingleRequestState extends Equatable {
  const TfbSingleRequestState();

  @override
  List<Object> get props => [];
}

class TfbSingleRequestInitial extends TfbSingleRequestState {}

class TfbSingleRequestProcessing extends TfbSingleRequestState {
  const TfbSingleRequestProcessing({this.isPullToRefresh = false});

  final bool isPullToRefresh;

  @override
  List<Object> get props => [isPullToRefresh];
}

class TfbSingleRequestFailed extends TfbSingleRequestState {
  const TfbSingleRequestFailed({
    required this.error,
  });

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}

class TfbSingleRequestSuccess<S extends Object> extends TfbSingleRequestState {
  const TfbSingleRequestSuccess({
    required this.response,
  });

  final S response;

  @override
  List<Object> get props => [response];
}
