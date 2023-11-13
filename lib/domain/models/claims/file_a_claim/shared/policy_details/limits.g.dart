// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Limits _$LimitsFromJson(Map<String, dynamic> json) => Limits(
      limitType: json['LimitType'] as String?,
      amount: json['Amount'] as String?,
    );

Map<String, dynamic> _$LimitsToJson(Limits instance) => <String, dynamic>{
      'LimitType': instance.limitType,
      'Amount': instance.amount,
    };
