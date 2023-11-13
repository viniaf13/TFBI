// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

/// MemberEnrollmentTypes are primarily for Billing. All policies enrolled in
/// paperless notifications return a member enrollment type of 'EML'
@JsonEnum(valueField: 'value')
enum MemberEnrollmentType {
  email('EML'), // receives email notifications only
  text('TXT'), // receives text notifications only
  both('BOTH'), // receives both
  undefined('undefined');

  const MemberEnrollmentType(this.value);

  final String value;
}
