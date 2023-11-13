// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_payment.g.dart';

@JsonSerializable()
class ClaimPayment {
  ClaimPayment({this.claimPayables});

  factory ClaimPayment.fromJson(Map<String, dynamic> json) =>
      _$ClaimPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimPaymentToJson(this);

  @JsonKey(name: 'claimPayables')
  final ClaimPayables? claimPayables;

  ClaimPayment copyWith({ClaimPayables? claimPayables}) =>
      ClaimPayment(claimPayables: claimPayables ?? this.claimPayables);
}
