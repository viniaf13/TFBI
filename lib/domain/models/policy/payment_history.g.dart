// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) =>
    PaymentHistory(
      json['Description'] as String?,
      json['OccurrenceNumber'] as String?,
      json['PaymentAmount'] as String?,
      json['PaymentDate'] as String?,
      json['RemainingBalance'] as String?,
    );

Map<String, dynamic> _$PaymentHistoryToJson(PaymentHistory instance) =>
    <String, dynamic>{
      'Description': instance.description,
      'OccurrenceNumber': instance.occurrenceNumber,
      'PaymentAmount': instance.paymentAmount,
      'PaymentDate': instance.paymentDate,
      'RemainingBalance': instance.remainingBalance,
    };
