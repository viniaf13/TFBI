// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_payments.g.dart';

@JsonSerializable()
class ClaimPayments {
  ClaimPayments({this.claimPayment});

  factory ClaimPayments.fromJson(Map<String, dynamic> json) =>
      _$ClaimPaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimPaymentsToJson(this);

  @JsonKey(name: 'claimPayment')
  final List<ClaimPayment>? claimPayment;

  ClaimPayments copyWith({List<ClaimPayment>? claimPayment}) =>
      ClaimPayments(claimPayment: claimPayment ?? this.claimPayment);

  @override
  String toString() {
    if (claimPayment!.isEmpty) {
      return 'No Payments Found';
    } else {
      final paymentStrings =
          claimPayment?.map((payment) => payment.toString()).join(', ');
      return 'Claim Payments: $paymentStrings';
    }
  }
}
