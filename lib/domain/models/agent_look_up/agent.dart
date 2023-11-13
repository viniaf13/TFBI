// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/domain.dart';

part 'generated_models/agent.g.dart';

// https://web.txfb-ins.com/services/TFBIC.Services.RESTAgent.Lookup/REST_AgentLookup.svc/Agents
@JsonSerializable()
class Agent {
  Agent({
    this.agentCode,
    this.agentName,
    this.countyName,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => _$AgentFromJson(json);
  Map<String, dynamic> toJson() => _$AgentToJson(this);

  @JsonKey(name: '_agentCode')
  final String? agentCode;
  @JsonKey(name: '_agentName')
  final String? agentName;
  @JsonKey(name: '_countyName')
  final String? countyName;
}
