// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/domain.dart';

part 'generated_models/agency_manager_code.g.dart';

@JsonSerializable()
class AgencyManagerCode {
  AgencyManagerCode({
    this.agentCode,
    this.errorMessage,
  });

  factory AgencyManagerCode.fromJson(Map<String, dynamic> json) =>
      _$AgencyManagerCodeFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyManagerCodeToJson(this);

  @JsonKey(name: '_agentCode')
  final String? agentCode;
  @JsonKey(name: '_errorMessage')
  final dynamic errorMessage;

  @override
  String toString() => 'Agency Manager Code: $agentCode';
}
