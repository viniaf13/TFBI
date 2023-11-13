// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';
import 'package:plugin_haven/plugin_haven.dart';

part 'generated_models/agent_details.g.dart';

@JsonSerializable()
class AgentDetails {
  AgentDetails({
    this.aboutText,
    this.agentCode,
    this.agentSinceDate,
    this.emailAddress,
    this.errorMessage,
    this.faxNumber,
    this.firstName,
    this.lastName,
    this.mailingAddress,
    this.mailingAddress2,
    this.mailingCity,
    this.mailingState,
    this.mailingZip,
    this.mailingZip4,
    this.phoneNumber,
    this.photo,
    this.physicalAddress,
    this.physicalAddress2,
    this.physicalCity,
    this.physicalState,
    this.physicalZip,
    this.physicalZip4,
    this.preferredName,
    this.titleDesignation,
  });

  factory AgentDetails.fromJson(Map<String, dynamic> json) =>
      _$AgentDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AgentDetailsToJson(this);

  @JsonKey(name: '_aboutText')
  final dynamic aboutText;
  @JsonKey(name: '_agentCode')
  final String? agentCode;
  @JsonKey(name: '_agentSinceDate')
  final String? agentSinceDate;
  @JsonKey(name: '_emailAddress')
  final String? emailAddress;
  @JsonKey(name: '_errorMessage')
  final dynamic errorMessage;
  @JsonKey(name: '_faxNumber')
  final String? faxNumber;
  @JsonKey(name: '_firstName')
  final String? firstName;
  @JsonKey(name: '_lastName')
  final String? lastName;
  @JsonKey(name: '_mailingAddress')
  final String? mailingAddress;
  @JsonKey(name: '_mailingAddress2')
  final String? mailingAddress2;
  @JsonKey(name: '_mailingCity')
  final String? mailingCity;
  @JsonKey(name: '_mailingState')
  final String? mailingState;
  @JsonKey(name: '_mailingZip')
  final String? mailingZip;
  @JsonKey(name: '_mailingZip4')
  final dynamic mailingZip4;
  @JsonKey(name: '_phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: '_photo')
  final String? photo;
  @JsonKey(name: '_physicalAddress')
  final String? physicalAddress;
  @JsonKey(name: '_physicalAddress2')
  final String? physicalAddress2;
  @JsonKey(name: '_physicalCity')
  final String? physicalCity;
  @JsonKey(name: '_physicalState')
  final String? physicalState;
  @JsonKey(name: '_physicalZip')
  final String? physicalZip;
  @JsonKey(name: '_physicalZip4')
  final dynamic physicalZip4;
  @JsonKey(name: '_preferredName')
  final String? preferredName;
  @JsonKey(name: '_titleDesignation')
  final String? titleDesignation;

  String get firstAndLastName => '$firstName $lastName';
  String get getTitleDesignation => titleDesignation ?? '';

  bool get hasPhone => !phoneNumber.isNullOrEmpty;
  bool get hasEmail => !emailAddress.isNullOrEmpty;

  @override
  String toString() =>
      'Agent: $firstName $lastName -- $agentCode, Phone: $phoneNumber, Email: $emailAddress';
}
