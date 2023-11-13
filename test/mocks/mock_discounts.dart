import 'dart:math';

import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';

abstract class MockDiscount {
  static Discount generateRandomDiscount() {
    final random = Random();

    final code = getRandomString(10, random);
    final description = getRandomString(10, random);
    final discountAmount = getRandomString(10, random);
    final discountAmountDescription = getRandomString(10, random);
    final discountType = getRandomString(10, random);
    final premiumAdjustment = getRandomString(10, random);

    return Discount(
      code,
      description,
      discountAmount,
      discountAmountDescription,
      discountType,
      premiumAdjustment,
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
