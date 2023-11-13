// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_payments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimPayments _$ClaimPaymentsFromJson(Map<String, dynamic> json) =>
    ClaimPayments(
      claimPayment: (json['claimPayment'] as List<dynamic>?)
          ?.map((e) => ClaimPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimPaymentsToJson(ClaimPayments instance) =>
    <String, dynamic>{
      'claimPayment': instance.claimPayment,
    };
