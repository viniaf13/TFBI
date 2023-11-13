// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimPayment _$ClaimPaymentFromJson(Map<String, dynamic> json) => ClaimPayment(
      claimPayables: json['claimPayables'] == null
          ? null
          : ClaimPayables.fromJson(
              json['claimPayables'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimPaymentToJson(ClaimPayment instance) =>
    <String, dynamic>{
      'claimPayables': instance.claimPayables,
    };
