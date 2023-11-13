// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  Contact({
    required this.contactId,
    required this.miraId,
    required this.fullName,
    required this.phoneNumber,
    required this.textEnabled,
    required this.verified,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @JsonKey(name: 'ContactId')
  final String contactId;
  @JsonKey(name: 'MiraId')
  final int miraId;
  @JsonKey(name: 'FullName')
  final String fullName;
  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;
  @JsonKey(name: 'TextEnabled')
  final bool textEnabled;
  @JsonKey(name: 'Verified')
  final bool verified;
}
