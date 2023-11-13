// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_literal_description_map.g.dart';

@JsonSerializable()
class ClaimLiteralDescriptionMap {
  ClaimLiteralDescriptionMap({
    this.claimEntry,
  });

  factory ClaimLiteralDescriptionMap.fromJson(Map<String, dynamic> json) =>
      _$ClaimLiteralDescriptionMapFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimLiteralDescriptionMapToJson(this);

  @JsonKey(name: 'entry')
  final List<ClaimEntry>? claimEntry;

  ClaimLiteralDescriptionMap copyWith({List<ClaimEntry>? entry}) =>
      ClaimLiteralDescriptionMap(claimEntry: entry ?? claimEntry);

  @override
  String toString() {
    return 'ClaimLiteralDescriptionMap {\n'
        '  claimEntry: ${claimEntry.toString()}\n'
        '}';
  }
}
