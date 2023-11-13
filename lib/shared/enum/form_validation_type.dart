import 'package:flutter/services.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

/// Defines the list of possible options for `ValidatingFormField` configurations.
/// Simplifies integration by packaging the most common & important
/// options into a single location.

enum ValidationType {
  none(
    minLength: 0,
    maxLength: 0,
    regex: r'',
    filter: r'',
    validationError: 'should never exist',
  ),
  phone(
    minLength: 10,
    maxLength: 12,
    regex: r'^$|^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$',
    filter: r'[\d\.\- \(\)]',
    keyboardType: TextInputType.numberWithOptions(
      signed: true,
    ),
    validationError: 'phone number',
  ),
  name(
    minLength: 2,
    maxLength: 60,
    regex: r"[A-Za-z0-9-&‘',. ]+$",
    filter: r"[A-Za-z0-9\-&‘',. ]",
  ),
  email(
    minLength: 3,
    maxLength: 250,
    regex:
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$', // I have concerns about this regex
    filter:
        r"[\w.@!#$%&'*+\-\/=?^_`{|}~]", // in double quotes because single quote is valid
    uppercaseOnly: true,
    keyboardType: TextInputType.emailAddress,
    validationError: 'email address',
  ),
  description(
    minLength: 2,
    maxLength: 1000,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?‘&#@()'* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?‘&#@()'* ]",
  ),
  location(
    minLength: 3,
    maxLength: 40,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]",
  ), // used for `location` and `vehicle location`
  city(
    minLength: 3,
    maxLength: 25,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]",
  ),
  policeDepartment(
    minLength: 2,
    maxLength: 40,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]",
  ),
  policeCaseNumber(
    minLength: 2,
    maxLength: 25,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?‘'&#@()* ]",
  ),
  zipCode(
    minLength: 5,
    maxLength: 5,
    regex: r'\d{5}',
    filter: r'\d',
    keyboardType: TextInputType.numberWithOptions(
      signed: true,
    ),
    validationError: 'zip code',
  ),
  streetAddress(
    minLength: 2,
    maxLength: 250,
    regex: r'[A-Za-z0-9\/\\_\-:.,;!?‘&#@()* ]+$',
    filter: r'[A-Za-z0-9\/\\_\-:.,;!?‘&#@()* ]',
  ),
  driversLicenseNumber(
    minLength: 4,
    maxLength: 13,
    regex: r'[A-Za-z0-9]+$',
    filter: r'[A-Za-z0-9]',
  ),
  licensePlateNumber(
    minLength: 2,
    maxLength: 10,
    regex: r'[A-Za-z0-9 ]+$',
    filter: r'[A-Za-z0-9 ]',
  ),
  firstName(
    minLength: 2,
    maxLength: 25,
    regex: r"[A-Za-z0-9-&',. ]+$",
    filter: r"[A-Za-z0-9\-&',. ]",
  ),
  lastName(
    minLength: 2,
    maxLength: 25,
    regex: r"[A-Za-z0-9-&',. ]+$",
    filter: r"[A-Za-z0-9\-&',. ]",
  ),
  involvedDriverFirstName(
    minLength: 3,
    maxLength: 50,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?'&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?'&#@()* ]",
  ),
  involvedDriverLastName(
    minLength: 3,
    maxLength: 50,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?'&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?'&#@()* ]",
  ),
  injuryDescription(
    minLength: 3,
    maxLength: 50,
    regex: r"[A-Za-z0-9\/\\_\-:.,;!?'’&#@()* ]+$",
    filter: r"[A-Za-z0-9\/\\_\-:.,;!?'’&#@()* ]",
  ),
  bankName(
    minLength: 2,
    maxLength: 25,
    regex: r"[A-Za-z0-9-&',. ]+$",
    filter: r"[A-Za-z0-9-&',. ]+$",
  ),
  bankAccountName(
    minLength: 4,
    maxLength: 60,
    regex: r"[A-Za-z0-9-&',. ]+$",
    filter: r"[A-Za-z0-9-&',. ]+$",
  ),
  bankRoutingNumber(
    minLength: 9,
    maxLength: 9,
    regex:
        r'/^((0[0-9])|(1[0-2])|(2[1-9])|(3[0-2])|(6[1-9])|(7[0-2])|80)([0-9]{​​​​​7}​​​',
    filter: r'\d',
    keyboardType: TextInputType.numberWithOptions(
      signed: true,
    ),
  ),
  bankAccountNumber(
    minLength: 4,
    maxLength: 17,
    regex: r'\d+$',
    filter: r'\d',
    keyboardType: TextInputType.numberWithOptions(
      signed: true,
    ),
  ),
  selection(
    minLength: 0,
    maxLength: 50,
    regex: r'(.|\s)*\S(.|\s)*',
    filter: r'(.|\s)*\S(.|\s)*',
    validationError: 'selectable',
  ); // used for all bottom sheet fields

  const ValidationType({
    required this.minLength,
    required this.maxLength,
    required this.regex,
    required this.filter,
    this.validationError,
    this.uppercaseOnly = false,
    this.keyboardType = TextInputType.text,
  });

  final int minLength;
  final int maxLength;
  final String regex; // a raw string to be used directly in the regex
  final String filter;
  final bool uppercaseOnly; // used when testing regex, does not modify field
  final TextInputType keyboardType;
  final String? validationError; // used for states other than length
}
