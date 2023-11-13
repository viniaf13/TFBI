import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_haven/util/extensions.dart';

void main() {
  group('Haven String extension tests', () {
    test('Capitalize', () {
      var sentence = 'capitalize this sentence';
      sentence = sentence.capitalize();
      expect(sentence, 'Capitalize this sentence');
      sentence = 'a';
      sentence = sentence.capitalize();
      expect(sentence, 'A');
    });
    test('Capitalize String Words', () {
      var sentence = 'capitalize this sentence';
      sentence = sentence.capitalizeString();
      expect(sentence, 'Capitalize This Sentence');
    });
    test('charAt (safe)', () {
      var string = '01234';
      expect(
        string.charAt(0) == '0' &&
            string.charAt(4) == '4' &&
            string.charAt(5) == '',
        true,
      );
    });
    test('Convert int to hex String', () {
      expect(255.toHexString(), 'ff');
    });
    test('String segment of length', () {
      var string = '1112333';
      var newString = string.segment(string.length - 3) +
          string.segment(0, 3) +
          string.segment(3, 1) +
          string.segment(47);
      expect(newString, '3331112');
    });
    test('insertAt String another string', () {
      var string = '1234';
      var newString = string
          .insertAt('^', string.length ~/ 2)
          .insertAt('^', 0)
          .insertAt('^', 1000);
      expect(newString, '^12^34^');
    });
    test('Convert String to int safely', () {
      expect(
        '123'.toIntSafe() == 123 &&
            'ff'.toIntSafe(radix: 16) == 255 &&
            'one'.toIntSafe(defaultValue: 1) == 1 &&
            ''.toIntSafe() == 0,
        true,
      );
    });
    test('String is int', () {
      expect(
        '123'.isInt() &&
            'ff'.isInt(radix: 16) &&
            !'abc'.isInt() &&
            !'123.'.isInt(),
        true,
      );
    });
    test('Valid email, test 1', () {
      expect('bob.smith@company.com'.isValidEmail(), true);
    });
    test('Valid email, test 2', () {
      expect('foo@'.isValidEmail(), false);
    });
    test('Valid email, test 3', () {
      expect('bob.smith@.company.com'.isValidEmail(), false);
    });
    test('Valid email, test 4', () {
      expect(
        'foo@bar.1234012345678901234567890123456789012345678901234567890123456789'
            .isValidEmail(),
        false,
      );
    });
    test('Obfuscate email, test 1', () {
      expect('bob.smith@company.com'.obfuscateEmail(), 'bo*****@company.com');
    });
    test('Obfuscate email, test 2', () {
      expect('xl@company.com'.obfuscateEmail(), '*****@company.com');
    });
    test('Obfuscate email, test 3', () {
      expect('not email'.obfuscateEmail(), 'not email');
    });
    test(', No character data String test', () {
      String? nullString;
      expect(
        ''.isNullOrEmpty && nullString.isNullOrEmpty && !'xxx'.isNullOrEmpty,
        true,
      );
    });
    test(', Null String value data String test', () {
      String? nullString;
      expect(
        nullString.nullSafeValue == '' && 'xxx'.nullSafeValue == 'xxx',
        true,
      );
    });
  });
}
