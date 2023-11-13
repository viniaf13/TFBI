// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberSummary _$MemberSummaryFromJson(Map<String, dynamic> json) =>
    MemberSummary(
      policies: (json['Policies'] as List<dynamic>)
          .map((e) => PolicySummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemberSummaryToJson(MemberSummary instance) =>
    <String, dynamic>{
      'Policies': instance.policies,
    };
