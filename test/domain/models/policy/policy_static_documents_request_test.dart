import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_documents_request.dart';

void main() {
  test('PolicyStaticDocumentsRequest should have correct properties', () {
    final request = PolicyStaticDocumentsRequest(
      expirationDate: '2023-10-13',
      policySymbol: 'ABC123',
    );

    expect(request.expirationDate, '2023-10-13');
    expect(request.policySymbol, 'ABC123');
  });

  test('PolicyStaticDocumentsRequest.fromJson should create correct instance',
      () {
    final Map<String, dynamic> json = {
      'PolicySymbol': 'XYZ789',
      'ExpirationDate': '2023-12-17',
    };

    final request = PolicyStaticDocumentsRequest.fromJson(json);

    expect(request.expirationDate, '2023-12-17');
    expect(request.policySymbol, 'XYZ789');
  });

  test('PolicyStaticDocumentsRequest.toJson should return correct Map', () {
    final request = PolicyStaticDocumentsRequest(
      expirationDate: '2024-01-19',
      policySymbol: 'GHI321',
    );

    final json = request.toJson();

    expect(json['ExpirationDate'], '2024-01-19');
    expect(json['PolicySymbol'], 'GHI321');
  });
}
