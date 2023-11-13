// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mortgagee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mortgagee _$MortgageeFromJson(Map<String, dynamic> json) => Mortgagee(
      json['Address'] as String,
      json['LoanNumber'] as String,
      json['Name'] as String,
      json['ObjectSequenceNumber'] as String,
      json['ObjectType'] as String,
      json['Type'] as String,
    );

Map<String, dynamic> _$MortgageeToJson(Mortgagee instance) => <String, dynamic>{
      'Address': instance.address,
      'LoanNumber': instance.loanNumber,
      'Name': instance.name,
      'ObjectSequenceNumber': instance.objectSequenceNumber,
      'ObjectType': instance.objectType,
      'Type': instance.type,
    };
