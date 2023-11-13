import 'dart:math';

import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';

import 'mock_coverage.dart';
import 'mock_discounts.dart';
import 'mock_lienholder.dart';

abstract class MockVehicles {
  static Vehicle generateRandomVehicle() {
    final random = Random();

    final classCode = getRandomString(10, random);
    final description = getRandomString(20, random);
    final coverages = [
      MockCoverage.generateRandomCoverage(),
      MockCoverage.generateRandomCoverage(),
    ];
    final discounts = [
      MockDiscount.generateRandomDiscount(),
      MockDiscount.generateRandomDiscount(),
    ];
    final endorsements = getRandomList(4, () => getRandomString(10, random));
    final lienHolders = [MockLienholder.generateRandomLienHolder()];
    final extendedClassCode = getRandomString(10, random);
    final garagingCounty = getRandomString(10, random);
    final hasLossPayee = random.nextBool().toString();
    final make = getRandomString(10, random);
    final model = getRandomString(10, random);
    final number = getRandomString(8, random);
    final totalCoveragePremium = getRandomDecimal(random);
    final totalDiscounts = getRandomDecimal(random);
    final totalVehiclePremium = getRandomDecimal(random);
    final vin = getRandomString(17, random);
    final year = (random.nextInt(24) + 2000).toString();

    return Vehicle(
      classCode,
      description,
      coverages,
      discounts,
      endorsements,
      lienHolders,
      extendedClassCode,
      garagingCounty,
      hasLossPayee,
      make,
      model,
      number,
      totalCoveragePremium,
      totalDiscounts,
      totalVehiclePremium,
      vin,
      year,
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
