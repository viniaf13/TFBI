// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  Member({
    this.lastLoginTimestamp,
    this.memberIdNumber,
    this.memberNumber,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @JsonKey(name: 'LastLoginTimestamp')
  final String? lastLoginTimestamp;
  @JsonKey(name: 'MemberIDNumber')
  final int? memberIdNumber;
  @JsonKey(name: 'MemberNumber')
  final String? memberNumber;
}
