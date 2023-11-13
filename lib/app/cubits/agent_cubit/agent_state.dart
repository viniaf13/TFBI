part of 'agent_cubit.dart';

abstract class AgentState extends Equatable {
  const AgentState();

  @override
  List<Object> get props => [];
}

class AgentInitial extends AgentState {}

class AgentProcessing extends AgentState {
  const AgentProcessing({required this.isPullToRefresh});

  final bool isPullToRefresh;

  @override
  List<Object> get props => [isPullToRefresh];
}

class AgentDetailsSuccess extends AgentState {
  const AgentDetailsSuccess({
    required this.agentDetails,
  });

  final AgentDetails agentDetails;

  @override
  List<Object> get props => [agentDetails];
}

class AgentCodeSuccess extends AgentState {}

class AgentFailure extends AgentState {
  const AgentFailure({
    required this.error,
  });

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
