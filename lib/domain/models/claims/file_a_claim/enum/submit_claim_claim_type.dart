// ignore_for_file: lower_camel_case_constants, constant_identifier_names, coverage:ignore-file
// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

@JsonEnum(valueField: 'value')
enum SubmitClaimClaimType {
  auto(0),
  property(1),
  undefined(-1);

  const SubmitClaimClaimType(this.value);

  final int value;
}
