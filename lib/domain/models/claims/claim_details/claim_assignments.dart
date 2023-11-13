// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_assignments.g.dart';

@JsonSerializable()
class ClaimAssignments {
  ClaimAssignments({this.importAssignmentDTO});

  factory ClaimAssignments.fromJson(Map<String, dynamic> json) =>
      _$ClaimAssignmentsFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimAssignmentsToJson(this);

  @JsonKey(name: 'importAssignmentDTO')
  final List<ClaimImportAssignmentDTO>? importAssignmentDTO;

  ClaimAssignments copyWith({
    List<ClaimImportAssignmentDTO>? importAssignmentDTO,
  }) =>
      ClaimAssignments(
        importAssignmentDTO: importAssignmentDTO ?? this.importAssignmentDTO,
      );

  @override
  String toString() {
    return 'ImportAssignmentDto: $importAssignmentDTO';
  }
}
