// ignore_for_file: lower_camel_case_constants, constant_identifier_names
// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum SubmitClaimUsStates {
  AL('Alabama', 'AL'),
  AK('Alaska', 'AK'),
  AZ('Arizona', 'AZ'),
  AR('Arkansas', 'AR'),
  CA('California', 'CA'),
  CO('Colorado', 'CO'),
  CT('Connecticut', 'CT'),
  DE('Delaware', 'DE'),
  FL('Florida', 'FL'),
  GA('Georgia', 'GA'),
  HI('Hawaii', 'HI'),
  ID('Idaho', 'ID'),
  IL('Illinois', 'IL'),
  IN('Indiana', 'IN'),
  IA('Iowa', 'IA'),
  KS('Kansas', 'KS'),
  KY('Kentucky', 'KY'),
  LA('Louisiana', 'LA'),
  ME('Maine', 'ME'),
  MD('Maryland', 'MD'),
  MA('Massachusetts', 'MA'),
  MI('Michigan', 'MI'),
  MN('Minnesota', 'MN'),
  MS('Mississippi', 'MS'),
  MO('Missouri', 'MO'),
  MT('Montana', 'MT'),
  NE('Nebraska', 'NE'),
  NV('Nevada', 'NV'),
  NH('New Hampshire', 'NH'),
  NJ('New Jersey', 'NJ'),
  NM('New Mexico', 'NM'),
  NY('New York', 'NY'),
  NC('North Carolina', 'NC'),
  ND('North Dakota', 'ND'),
  OH('Ohio', 'OH'),
  OK('Oklahoma', 'OK'),
  OR('Oregon', 'OR'),
  PA('Pennsylvania', 'PA'),
  RI('Rhode Island', 'RI'),
  SC('South Carolina', 'SC'),
  SD('South Dakota', 'SD'),
  TN('Tennessee', 'TN'),
  TX('Texas', 'TX'),
  UT('Utah', 'UT'),
  VT('Vermont', 'VT'),
  VA('Virginia', 'VA'),
  WA('Washington', 'WA'),
  WV('West Virginia', 'WV'),
  WI('Wisconsin', 'WI'),
  WY('Wyoming', 'WY'),

  PR('Puerto Rico', 'PR'),
  VI('Virgin Islands', 'VI'),
  GU('Guam', 'GU'),
  AS('American Samoa', 'AS'),
  MP('Northern Mariana Islands', 'MP'),

  other('Other', 'Other');

  const SubmitClaimUsStates(this.value, this.abbreviation);

  final String value;
  final String abbreviation;

  static String? getValueFromAbbreviation(String? abbreviation) {
    final state = SubmitClaimUsStates.values
        .where(
          (element) => element.abbreviation == abbreviation,
        )
        .firstOrNull;
    if (state != null) {
      return state.value;
    }
    return null;
  }

  @override
  String toString() {
    return value;
  }
}
