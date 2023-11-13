// coverage:ignore-file
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';

part 'claim_entry.g.dart';

@JsonSerializable()
class ClaimEntry {
  ClaimEntry({
    this.string,
  });

  factory ClaimEntry.fromJson(Map<String, dynamic> json) =>
      _$ClaimEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimEntryToJson(this);

  @JsonKey(name: 'entry')
  final List<String>? string;

  ClaimEntry copyWith({List<String>? string}) =>
      ClaimEntry(string: string ?? this.string);
}
