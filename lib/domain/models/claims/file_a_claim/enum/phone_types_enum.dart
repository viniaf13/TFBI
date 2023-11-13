// ignore_for_file: lower_camel_case_constants, constant_identifier_names
// coverage:ignore-file

import 'package:txfb_insurance_flutter/data/data.dart';

@JsonEnum(valueField: 'value')
enum PhoneTypesEnum {
  busn_phn('Business Phone'),
  hm_phn('Home Phone'),
  cell_phn('Cellular Phone'),
  fax('Fax'),
  undefined('Undefined');

  const PhoneTypesEnum(this.value);

  final String value;

  String? code() {
    switch (this) {
      case busn_phn:
        return 'busn_phn';
      case hm_phn:
        return 'hm_phn';
      case cell_phn:
        return 'cell_phn';
      default:
        return 'undefined';
    }
  }

  String? uiValue() {
    switch (this) {
      case busn_phn:
        return 'Business';
      case hm_phn:
        return 'Home';
      case cell_phn:
        return 'Cell';
      case fax:
        return value;
      default:
        return 'undefined';
    }
  }

  static String getUiValueFromValue(String? value) {
    switch (value) {
      case 'busn_phn':
        return 'Business';
      case 'hm_phn':
        return 'Home';
      case 'cell_phn':
        return 'Cell';
      case 'fax':
        return 'Fax';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return value;
  }
}
