import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'agent_state.dart';

class AgentCubit extends Cubit<AgentState> {
  AgentCubit({required this.repository}) : super(AgentInitial());
  final TfbAgentLookupRepository repository;

  Future<void> getAgent(
    String? memberNumber, {
    bool isPullToRefresh = false,
  }) async {
    try {
      emit(AgentProcessing(isPullToRefresh: isPullToRefresh));

      final agent = await repository.getAgentCode(memberNumber!);

      if (agent!.agentCode.isNullOrEmpty) {
        emit(AgentCodeSuccess());
        return;
      }

      final agentDetails = await repository.getAgentDetails(agent.agentCode!);

      emit(AgentDetailsSuccess(agentDetails: agentDetails!));
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      TfbLogger.exception(
        'Get agent cubit call failed with error:',
        error,
        stack,
      );
      emit(AgentFailure(error: error));
    }
  }
}
