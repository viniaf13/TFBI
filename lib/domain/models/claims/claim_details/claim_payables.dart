// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_payables.g.dart';

@JsonSerializable()
class ClaimPayables {
  ClaimPayables({this.claimPayable});

  factory ClaimPayables.fromJson(Map<String, dynamic> json) =>
      _$ClaimPayablesFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimPayablesToJson(this);

  @JsonKey(name: 'claimPayable')
  final List<ClaimPayable>? claimPayable;

  ClaimPayables copyWith({
    List<ClaimPayable>? claimPayable,
  }) =>
      ClaimPayables(
        claimPayable: claimPayable ?? this.claimPayable,
      );
}
