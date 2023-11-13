//  Copyright © 2022 Bottle Rocket Studios. All rights reserved.
import 'dart:math';

/// Commom string utilities
extension StringExtensions on String {
  /// 'Safe' string accessors
  /// Get a character at index i, empty string if out of range
  String charAt(int i) =>
      (isEmpty || i < 0 || i >= length) ? '' : substring(i, i + 1);

  /// Insert another string at start, inside, or end of this string
  String insertAt(String insertionString, [int? index]) {
    int insertionPoint = index ?? length;
    if (insertionPoint < 0) {
      insertionPoint = 0;
    } else if (insertionPoint > length) {
      insertionPoint = length;
    }
    return (StringBuffer()
          ..write(substring(0, insertionPoint))
          ..write(insertionString)
          ..write(substring(insertionPoint)))
        .toString();
  }

  /// Safe alternative to substring, but using length: '' if 'i' bounds error
  String segment(int i, [int? len]) {
    final int segLast = (len == null) ? length : (i + min(len, length));
    return (isEmpty || i < 0 || i >= length) ? '' : substring(i, segLast);
  }

  /// Capitalize the first character in a string
  String capitalize() => '${charAt(0).toUpperCase()}${segment(1)}';

  /// Capitalize each word in a string (optionally trim start/end whitespace)
  /// Example: "  your name " => "Your Name"
  String capitalizeString({bool trim = true}) {
    final caps = split(RegExp(r'\s+')).map((e) => e.capitalize()).join(' ');
    return trim ? caps.trim() : caps;
  }

  /// Convert to a string safely with a default value
  int toIntSafe({int radix = 10, int defaultValue = 0}) =>
      int.tryParse(this, radix: radix) ?? defaultValue;

  ///
  bool isInt({int radix = 10}) => int.tryParse(this, radix: radix) != null;

  /// Using W3C HTML5 version considered 'good', subjective, yet widely accepted.
  bool isValidEmail() => RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
      ).hasMatch(this);

  // Simple mechanism to obfuscate an email
  String obfuscateEmail() {
    try {
      var hide = split("@")[0].length;
      var r = RegExp(".{${max(min(2, hide), hide - 2)}}@");
      return replaceFirst(r, "${'*' * 5}@");
    } catch (exception) {
      return this;
    }
  }
}

extension StringFromIntExtensions on int {
  /// Hex string
  String toHexString() => toRadixString(16);
}

extension NullableStringExtensions on String? {
  /// Check if String? has no characters, i.e. null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Treat String? as '' when null else self
  String get nullSafeValue => this ?? '';
}
