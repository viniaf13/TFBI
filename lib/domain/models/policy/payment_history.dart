// coverage:ignore-file

import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'payment_history.g.dart';

@JsonSerializable()
class PaymentHistory {
  PaymentHistory(
    this.description,
    this.occurrenceNumber,
    this.paymentAmount,
    this.paymentDate,
    this.remainingBalance,
  );

  factory PaymentHistory.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryFromJson(json);

  @JsonKey(name: 'Description')
  final String? description;
  @JsonKey(name: 'OccurrenceNumber')
  final String? occurrenceNumber;
  @JsonKey(name: 'PaymentAmount')
  final String? paymentAmount;
  @JsonKey(name: 'PaymentDate')
  final String? paymentDate;
  @JsonKey(name: 'RemainingBalance')
  final String? remainingBalance;

  Map<String, dynamic> toJson() => _$PaymentHistoryToJson(this);
}
