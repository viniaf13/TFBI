// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

part 'generated/submit_claim_loss_info.g.dart';

@JsonSerializable()
class LossInformation {
  const LossInformation({
    this.dateOfLoss,
    this.timeOfLoss,
    this.typeOfLoss,
    this.lossDescription,
    this.location,
    this.city,
    this.state,
    this.county,
    this.zip,
    this.policeDepartment,
    this.policeCaseNumber,
  });

  factory LossInformation.fromJson(Map<String, dynamic> json) =>
      _$LossInformationFromJson(json);
  Map<String, dynamic> toJson() => _$LossInformationToJson(this);

  final String? dateOfLoss;
  final String? timeOfLoss;
  @JsonKey(name: 'typeOfLoss')
  final String? typeOfLoss;
  final String? lossDescription;
  final String? location;
  final String? city;
  final String? state;
  final String? county;
  final String? zip;
  final String? policeDepartment;
  final String? policeCaseNumber;

  LossInformation copyWith({
    String? dateOfLoss,
    String? timeOfLoss,
    String? typeOfLoss,
    String? lossDescription,
    String? location,
    String? city,
    String? state,
    String? county,
    String? zip,
    String? policeDepartment,
    String? policeCaseNumber,
  }) =>
      LossInformation(
        dateOfLoss: dateOfLoss ?? this.dateOfLoss,
        timeOfLoss: timeOfLoss ?? this.timeOfLoss,
        typeOfLoss: typeOfLoss ?? this.typeOfLoss,
        lossDescription: lossDescription ?? this.lossDescription,
        location: location ?? this.location,
        city: city ?? this.city,
        state: state ?? this.state,
        county: county ?? this.county,
        zip: zip ?? this.zip,
        policeDepartment: policeDepartment ?? this.policeDepartment,
        policeCaseNumber: policeCaseNumber ?? this.policeCaseNumber,
      );
}
