// ignore_for_file: lower_camel_case_constants, constant_identifier_names
// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';

@JsonEnum(valueField: 'value')
enum PropertyLossTypesEnum {
  fire('Fire'),
  liab('Liability'),
  prop('Property'),
  storm('Storm'),
  undefined('undefined');

  const PropertyLossTypesEnum(this.value);

  final String value;

  // Probably overkill as returning any code is simply the .name of the typeOfLoss
  String code() {
    switch (this) {
      case fire:
        return fire.name;
      case liab:
        return liab.name;
      case prop:
        return prop.name;
      case storm:
        return storm.name;
      default:
        return undefined.name;
    }
  }
}
