// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDetails _$ClaimDetailsFromJson(Map<String, dynamic> json) => ClaimDetails(
      claimId: json['claimId'] as String?,
      claimNumber: json['claimNumber'] as String?,
      isActiveCompanyLobCode: json['isActiveCompanyLobCode'] as String?,
      companyId: json['companyId'] as String?,
      closeRecovery: json['closeRecovery'] as String?,
      modifyRecovery: json['modifyRecovery'] as String?,
      claimBlocksCompositeDto:
          (json['claimBlocksCompositeDto'] as List<dynamic>?)
              ?.map((e) =>
                  ClaimBlocksCompositeDto.fromJson(e as Map<String, dynamic>))
              .toList(),
      claimDto: json['claimDto'] == null
          ? null
          : ClaimDto.fromJson(json['claimDto'] as Map<String, dynamic>),
      claimPayments: json['claimPayments'] == null
          ? null
          : ClaimPayments.fromJson(
              json['claimPayments'] as Map<String, dynamic>),
      claimAssignments: json['claimAssignments'] == null
          ? null
          : ClaimAssignments.fromJson(
              json['claimAssignments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimDetailsToJson(ClaimDetails instance) =>
    <String, dynamic>{
      'claimId': instance.claimId,
      'claimNumber': instance.claimNumber,
      'isActiveCompanyLobCode': instance.isActiveCompanyLobCode,
      'companyId': instance.companyId,
      'closeRecovery': instance.closeRecovery,
      'modifyRecovery': instance.modifyRecovery,
      'claimBlocksCompositeDto': instance.claimBlocksCompositeDto,
      'claimDto': instance.claimDto,
      'claimPayments': instance.claimPayments,
      'claimAssignments': instance.claimAssignments,
    };
