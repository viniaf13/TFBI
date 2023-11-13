import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/mortgagee.dart';

void main() {
  test('Mortgagee should have correct properties', () {
    final mortgagee = Mortgagee(
      '123 Main St',
      'M12345',
      'John Doe',
      '1',
      'Type A',
      'Type B',
    );

    expect(mortgagee.address, '123 Main St');
    expect(mortgagee.loanNumber, 'M12345');
    expect(mortgagee.name, 'John Doe');
    expect(mortgagee.objectSequenceNumber, '1');
    expect(mortgagee.objectType, 'Type A');
    expect(mortgagee.type, 'Type B');
  });

  test('Mortgagee.fromJson should create correct instance', () {
    final Map<String, dynamic> json = {
      'Address': '456 Oak St',
      'LoanNumber': 'L67890',
      'Name': 'Jane Smith',
      'ObjectSequenceNumber': '2',
      'ObjectType': 'Type C',
      'Type': 'Type D',
    };

    final mortgagee = Mortgagee.fromJson(json);

    expect(mortgagee.address, '456 Oak St');
    expect(mortgagee.loanNumber, 'L67890');
    expect(mortgagee.name, 'Jane Smith');
    expect(mortgagee.objectSequenceNumber, '2');
    expect(mortgagee.objectType, 'Type C');
    expect(mortgagee.type, 'Type D');
  });

  test('Mortgagee.toJson should return correct Map', () {
    final mortgagee = Mortgagee(
      '789 Pine St',
      'P54321',
      'Jim Brown',
      '3',
      'Type E',
      'Type F',
    );

    final json = mortgagee.toJson();

    expect(json['Address'], '789 Pine St');
    expect(json['LoanNumber'], 'P54321');
    expect(json['Name'], 'Jim Brown');
    expect(json['ObjectSequenceNumber'], '3');
    expect(json['ObjectType'], 'Type E');
    expect(json['Type'], 'Type F');
  });
}
