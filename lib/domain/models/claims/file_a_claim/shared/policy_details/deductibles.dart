// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'deductibles.g.dart';

@JsonSerializable()
class Deductibles {
  Deductibles({this.deductibleType, this.amount});

  factory Deductibles.fromJson(Map<String, dynamic> json) =>
      _$DeductiblesFromJson(json);

  @JsonKey(name: 'DeductibleType')
  String? deductibleType;
  @JsonKey(name: 'Amount')
  String? amount;
  Map<String, dynamic> toJson() => _$DeductiblesToJson(this);
}
