import 'dart:math';

import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';

abstract class MockCoverage {
  static Coverage generateRandomCoverage() {
    final random = Random();

    final coverageType = getRandomString(10, random);
    final description = getRandomString(10, random);
    final limitDescription =
        getRandomList(3, () => getRandomString(10, random));
    final coverageTypeDescription = getRandomString(10, random);
    final deductible = getRandomString(10, random);
    final limit = getRandomString(10, random);
    final premium = getRandomString(10, random);
    final sequence = getRandomString(10, random);

    return Coverage(
      coverageType,
      coverageTypeDescription,
      deductible,
      description,
      limit,
      limitDescription,
      premium,
      sequence,
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
