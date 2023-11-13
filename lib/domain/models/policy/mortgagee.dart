import 'package:txfb_insurance_flutter/data/data.dart';
part 'mortgagee.g.dart';

@JsonSerializable()
class Mortgagee {
  Mortgagee(
    this.address,
    this.loanNumber,
    this.name,
    this.objectSequenceNumber,
    this.objectType,
    this.type,
  );

  factory Mortgagee.fromJson(Map<String, dynamic> json) =>
      _$MortgageeFromJson(json);

  @JsonKey(name: 'Address')
  final String address;
  @JsonKey(name: 'LoanNumber')
  final String loanNumber;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'ObjectSequenceNumber')
  final String objectSequenceNumber;
  @JsonKey(name: 'ObjectType')
  final String objectType;
  @JsonKey(name: 'Type')
  final String type;

  Map<String, dynamic> toJson() => _$MortgageeToJson(this);
}
