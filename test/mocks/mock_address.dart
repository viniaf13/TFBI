import 'dart:math';

import 'package:txfb_insurance_flutter/domain/domain.dart';

abstract class MockAddress {
  static Address generateRandomAddress() {
    final random = Random();

    final address = getRandomString(10, random);
    final address2 = getRandomString(20, random);
    final address3 = getRandomString(10, random);
    final city = getRandomString(10, random);
    final state = getRandomString(10, random);
    final zipCode = getRandomString(5, random);
    final zipCode4 = getRandomString(20, random);
    final zipCode2 = getRandomString(20, random);

    return Address(
      address,
      address2,
      address3,
      city,
      state,
      zipCode,
      zipCode4,
      zipCode2,
    );
  }

  static String getRandomString(int length, Random random) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  static List<T> getRandomList<T>(int length, T Function() generator) {
    return List<T>.generate(length, (_) => generator());
  }

  static String getRandomDecimal(Random random) {
    return (random.nextDouble() * 1000).toStringAsFixed(2);
  }
}
