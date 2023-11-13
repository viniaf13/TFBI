// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'generated_models/agent_code.g.dart';

@JsonSerializable()
class AgentCode {
  AgentCode({
    this.agentCode,
    this.errorMessage,
  });

  factory AgentCode.fromJson(Map<String, dynamic> json) =>
      _$AgentCodeFromJson(json);
  Map<String, dynamic> toJson() => _$AgentCodeToJson(this);

  @JsonKey(name: '_agentCode')
  final String? agentCode;
  @JsonKey(name: '_errorMessage')
  final String? errorMessage;

  @override
  String toString() => 'Agent Code: $agentCode';
}
