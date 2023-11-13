// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_assignments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimAssignments _$ClaimAssignmentsFromJson(Map<String, dynamic> json) =>
    ClaimAssignments(
      importAssignmentDTO: (json['importAssignmentDTO'] as List<dynamic>?)
          ?.map((e) =>
              ClaimImportAssignmentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClaimAssignmentsToJson(ClaimAssignments instance) =>
    <String, dynamic>{
      'importAssignmentDTO': instance.importAssignmentDTO,
    };
