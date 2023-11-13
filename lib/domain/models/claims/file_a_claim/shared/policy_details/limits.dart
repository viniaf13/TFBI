// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'limits.g.dart';

@JsonSerializable()
class Limits {
  Limits({
    this.limitType,
    this.amount,
  });

  factory Limits.fromJson(Map<String, dynamic> json) => _$LimitsFromJson(json);

  @JsonKey(name: 'LimitType')
  String? limitType;
  @JsonKey(name: 'Amount')
  String? amount;
  Map<String, dynamic> toJson() => _$LimitsToJson(this);
}
