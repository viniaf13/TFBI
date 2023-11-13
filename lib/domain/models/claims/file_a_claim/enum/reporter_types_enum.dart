// ignore_for_file: lower_camel_case_constants, constant_identifier_names, coverage:ignore-file
// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

@JsonEnum(valueField: 'value')
enum ReporterTypesEnum {
  insured('Insured'),
  agent('Insureds Agent'),
  claimant('Claimant'),
  other('Other'),
  undefined('undefined');

  const ReporterTypesEnum(this.value);

  final String value;

  @override
  String toString() {
    return value;
  }
}
