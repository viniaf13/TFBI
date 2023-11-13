// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

part 'generated/submit_claim_address.g.dart';

@JsonSerializable()
class SubmitClaimAddress {
  const SubmitClaimAddress({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zip,
  });

  factory SubmitClaimAddress.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimAddressFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitClaimAddressToJson(this);

  @JsonKey(name: 'AddressLine1')
  final String? addressLine1;
  @JsonKey(name: 'AddressLine2')
  final String? addressLine2;
  @JsonKey(name: 'City')
  final String? city;
  @JsonKey(name: 'State')
  final String? state;
  @JsonKey(name: 'Zip')
  final String? zip;

  SubmitClaimAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? zip,
  }) =>
      SubmitClaimAddress(
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        city: city ?? this.city,
        state: state ?? this.state,
        zip: zip ?? this.zip,
      );
}
