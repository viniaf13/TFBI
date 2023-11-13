// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';

part 'member_address.g.dart';

@JsonSerializable()
class MemberAddress {
  MemberAddress({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipcode,
    this.zipcode2,
    this.zipcode4,
  });

  factory MemberAddress.fromJson(Map<String, dynamic> json) =>
      _$MemberAddressFromJson(json);

  Map<String, dynamic> toJson() => _$MemberAddressToJson(this);

  @JsonKey(name: 'AddressLine1')
  final String? addressLine1;
  @JsonKey(name: 'AddressLine2')
  final String? addressLine2;
  @JsonKey(name: 'City')
  final String? city;
  @JsonKey(name: 'State')
  final String? state;
  @JsonKey(name: 'Zipcode')
  final String? zipcode;
  @JsonKey(name: 'Zipcode2')
  final String? zipcode2;
  @JsonKey(name: 'Zipcode4')
  final String? zipcode4;
}
