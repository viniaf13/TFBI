// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claims_list.g.dart';

@JsonSerializable()
class ClaimsList {
  ClaimsList({this.claims});

  factory ClaimsList.fromJson(Map<String, dynamic> json) =>
      _$ClaimsListFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimsListToJson(this);

  @JsonKey(name: 'claims')
  final List<Claim>? claims;

  ClaimsList copyWith({List<Claim>? claims}) =>
      ClaimsList(claims: claims ?? this.claims);

  @override
  String toString() {
    return 'ClaimsList claims: ${claims.toString()}';
  }
}
