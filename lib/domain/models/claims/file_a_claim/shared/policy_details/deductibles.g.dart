// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deductibles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deductibles _$DeductiblesFromJson(Map<String, dynamic> json) => Deductibles(
      deductibleType: json['DeductibleType'] as String?,
      amount: json['Amount'] as String?,
    );

Map<String, dynamic> _$DeductiblesToJson(Deductibles instance) =>
    <String, dynamic>{
      'DeductibleType': instance.deductibleType,
      'Amount': instance.amount,
    };
