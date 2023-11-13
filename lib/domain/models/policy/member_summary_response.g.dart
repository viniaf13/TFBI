// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberSummaryResponse _$MemberSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    MemberSummaryResponse(
      policies: (json['Policies'] as List<dynamic>?)
          ?.map((e) => PolicySummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['ErrorMessage'] as String?,
    );

Map<String, dynamic> _$MemberSummaryResponseToJson(
        MemberSummaryResponse instance) =>
    <String, dynamic>{
      'Policies': instance.policies,
      'ErrorMessage': instance.errorMessage,
    };
