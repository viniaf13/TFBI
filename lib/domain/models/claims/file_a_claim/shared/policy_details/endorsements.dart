// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'endorsements.g.dart';

@JsonSerializable()
class Endorsements {
  Endorsements({
    this.id,
    this.number,
    this.name,
  });

  factory Endorsements.fromJson(Map<String, dynamic> json) =>
      _$EndorsementsFromJson(json);

  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Number')
  String? number;
  @JsonKey(name: 'Name')
  String? name;
  Map<String, dynamic> toJson() => _$EndorsementsToJson(this);
}
