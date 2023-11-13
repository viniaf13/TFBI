import 'package:txfb_insurance_flutter/domain/clients/agent_look_up_client.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

class TfbAgentLookupRepository {
  TfbAgentLookupRepository({
    required AgentLookUpClient client,
  }) : _client = client;

  final AgentLookUpClient _client;

  Future<AgentCode?> getAgentCode(String memberNumber) async {
    try {
      return await _client.getAgentCodeByMemberNumber(memberNumber);
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      TfbLogger.exception(
        'Get agent code call failed with error:',
        error,
        stack,
      );
      throw error;
    }
  }

  Future<AgentDetails?> getAgentDetails(String agentCode) async {
    try {
      return await _client.getAgentDetailsByAgentCode(agentCode);
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      TfbLogger.exception(
        'Get agent details call failed with error:',
        error,
        stack,
      );
      throw error;
    }
  }
}
