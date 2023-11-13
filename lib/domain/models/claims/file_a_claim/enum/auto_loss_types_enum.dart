// ignore_for_file: lower_camel_case_constants, constant_identifier_names
// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';

@JsonEnum(valueField: 'value')
enum AutoLossTypesEnum {
  autoglass('Auto Glass'),
  cainjr('Injury'),
  caprop('Property'),
  rentalveh('Rental Vehicle'),
  pacompnot('Comp Causes Not Specified'),
  enstire('Ensuing Damage From Tire Tread Blow-out'),
  pafire('Fire'),
  paflood('Flood, Rising Water or Other Water Damage'),
  pagravel('Flying Gravel or Falling Missiles'),
  paglassrepair('Glass Repair'),
  paglassreplace('Glass Replace'),
  pahail('Hail or Ensuing Storm'),
  pahitrun('Hit and Run'),
  pahitanimal('Hit Domestic/Farm Animal or Fowl'),
  pawild('Hit Wild Animal'),
  palegpark('Legally Parked, Stopped, Standing (Driver in Vehicle)'),
  pamulti('Multi-Vehicle Collision'),
  pamultiinj('Multi-Vehicle Collision with Injuries'),
  parear('Rear-end Collision'),
  rent('Rental Vehicle Damage'),
  paroad('Roadside Assistance (Towing)'),
  pasingle('Single Car Collision'),
  pasingleinj('Single Car Collision with Injuries'),
  patheft('Theft'),
  pavand('Vandalism/Partial Theft of Vehicle'),
  undefined('undefined');

  const AutoLossTypesEnum(this.value);

  final String value;

  String code() => name;

  @override
  String toString() {
    return value;
  }
}
