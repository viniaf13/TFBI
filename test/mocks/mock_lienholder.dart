import 'dart:math';

import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';

import 'mock_address.dart';

abstract class MockLienholder {
  static LienHolder generateRandomLienHolder() {
    final random = Random();

    final address = MockAddress.generateRandomAddress();
    final effectiveDate = getRandomString(20, random);
    final lienHolderType = getRandomString(10, random);
    final loanNumber = getRandomString(10, random);
    final logicalSequenceNumber = getRandomString(10, random);
    final name = getRandomString(20, random);
    final objectSequenceNumber = getRandomString(20, random);
    final occurrenceNumber = getRandomString(20, random);
    final suspendIndicator = getRandomString(20, random);
    final vehicleIdNumber = getRandomString(20, random);

    return LienHolder(
      address,
      effectiveDate,
      lienHolderType,
      loanNumber,
      logicalSequenceNumber,
      name,
      objectSequenceNumber,
      occurrenceNumber,
      suspendIndicator,
      vehicleIdNumber,
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
