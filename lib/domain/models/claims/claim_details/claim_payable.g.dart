// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_payable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimPayable _$ClaimPayableFromJson(Map<String, dynamic> json) => ClaimPayable(
      literalDescriptionMap: json['literalDescriptionMap'] == null
          ? null
          : ClaimLiteralDescriptionMap.fromJson(
              json['literalDescriptionMap'] as Map<String, dynamic>),
      transactionAmount: json['transactionAmount'] as String?,
      clmCoverageCode: json['clmCoverageCode'] as String?,
    );

Map<String, dynamic> _$ClaimPayableToJson(ClaimPayable instance) =>
    <String, dynamic>{
      'literalDescriptionMap': instance.literalDescriptionMap,
      'transactionAmount': instance.transactionAmount,
      'clmCoverageCode': instance.clmCoverageCode,
    };
