final List<String> allowedNumbers = '1234567890'.split('');
final List<String> allowedLowercaseLetters =
    'abcdefghijklmnopqrstuvwxyz'.split('');
final List<String> allowedUppercaseLetters =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
final List<String> allowedOtherCharacters =
    r'~!@#$%^&*()_-+= {[}]|\;"<,>.?/ '.split('');
final List<String> allowedLetters = [
  ...allowedLowercaseLetters,
  ...allowedUppercaseLetters,
];

final List<String> allAllowedCharacters = [
  ...allowedOtherCharacters,
  ...allowedLetters,
  ...allowedNumbers,
];

extension StringValidators on String {
  bool hasNLetters(int N) {
    return hasNCharacterInSet(N, allowedLetters);
  }

  bool hasNNumbers(int N) {
    return hasNCharacterInSet(N, allowedNumbers);
  }

  bool hasNUppercaseLetters(int N) {
    return hasNCharacterInSet(N, allowedUppercaseLetters);
  }

  bool isAlphanumeric() {
    return split('').every(
      (element) => [...allowedLetters, ...allowedNumbers].contains(element),
    );
  }

  bool isAlpha() {
    return split('').every(
      (element) => [...allowedLetters, ' '].contains(element),
    );
  }

  bool isNumeric() {
    return split('').every(
      allowedNumbers.contains,
    );
  }

  bool usesOnlyAllowedCharacters() {
    return split('').every(allAllowedCharacters.contains);
  }

  bool hasMoreThanNConcurrentLetters(int N) {
    int currentCount = 0;
    String lastLetter = '';
    for (final letter in split('')) {
      if (lastLetter == letter) {
        currentCount++;
        if (currentCount > (N - 1)) {
          return true;
        }
      } else {
        currentCount = 0;
      }
      lastLetter = letter;
    }
    return false;
  }

  bool hasNCharacterInSet(int N, List<String> characterSet) {
    return split('')
            .where(
              characterSet.contains,
            )
            .length >=
        N;
  }
}
