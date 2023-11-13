import 'package:intl/intl.dart';

NumberFormat getUsFormat({bool showDecimal = false}) => NumberFormat(
      showDecimal ? '#,##0.00' : '#,##0',
      'en_US',
    );

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension PhoneNumberFormat on String {
  String formatPhoneNumber() {
    try {
      return '${substring(0, 3)}.${substring(3, 6)}.${substring(6, 10)}';
    } catch (e) {
      return this;
    }
  }
}

extension CurrencyFormat on String? {
  String formatCurrency({bool showDecimal = false}) {
    if (this == null) return '-';

    final number = double.tryParse(this!);

    if (number == null) return '-';

    final usFormat = getUsFormat(showDecimal: showDecimal);
    return number.isNegative
        ? '-\$${usFormat.format(number.abs())}'
        : '\$${usFormat.format(number)}';
  }
}

extension AppVersionCheck on String {
  bool compareVersionNumbers(String minVersion) {
    final currentVersion = parseVersionString();
    final minimumVersion = minVersion.parseVersionString();

    final response = currentVersion[0] < minimumVersion[0] ||
        currentVersion[1] < minimumVersion[1] ||
        currentVersion[2] < minimumVersion[2];

    return response;
  }
}

extension AppVersionNumber on String {
  List<int> parseVersionString() => split('.').map(int.parse).toList();
}
