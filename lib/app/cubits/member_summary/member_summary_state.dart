part of 'member_summary_cubit.dart';

abstract class MemberSummaryState extends Equatable {
  const MemberSummaryState();

  @override
  List<Object> get props => [];
}

class MemberSummaryInitial extends MemberSummaryState {}

class MemberSummaryProcessing extends MemberSummaryState {
  const MemberSummaryProcessing({required this.isPullToRefresh});

  final bool isPullToRefresh;

  @override
  List<Object> get props => [isPullToRefresh];
}

class MemberSummarySuccess extends MemberSummaryState {
  const MemberSummarySuccess({
    required this.memberSummary,
  });

  final MemberSummary memberSummary;

  @override
  List<Object> get props => [memberSummary];
}

// Derives from MemberSummarySuccess so Widgets can just depend
// on policy list and that success state.
class MemberSummaryDetailsSuccess extends MemberSummarySuccess {
  const MemberSummaryDetailsSuccess({
    required super.memberSummary,
    required this.policyMap,
    this.error,
  });

  final Map<String, PolicyDetail> policyMap;
  final TfbRequestError? error;

  @override
  List<Object> get props => [policyMap, (error?.exception == null)];
}

class MemberSummaryFailure extends MemberSummaryState {
  const MemberSummaryFailure({
    required this.error,
  });

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
