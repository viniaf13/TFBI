import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class MockJsonMap extends Mock implements Map<String, dynamic> {}

void main() {
  group('PolicyListMetadata', () {
    late PolicyListMetadata policyListMetadata;
    late MockJsonMap mockJsonMap;

    setUp(() {
      mockJsonMap = MockJsonMap();
      policyListMetadata = PolicyListMetadata(
        date: '2023-08-18',
        documentId: '12345',
        formDescription: 'Sample Form',
        labelDescription: 'Sample Label',
        pageNumber: 1,
        versionId: 'v1',
      );
    });

    test('fromJson should correctly initialize PolicyListMetadata', () {
      when(() => mockJsonMap['Date']).thenReturn('2023-08-18');
      when(() => mockJsonMap['DocumentId']).thenReturn('12345');
      when(() => mockJsonMap['FormDescription']).thenReturn('Sample Form');
      when(() => mockJsonMap['LabelDescription']).thenReturn('Sample Label');
      when(() => mockJsonMap['PageNumber']).thenReturn(1);
      when(() => mockJsonMap['VersionId']).thenReturn('v1');

      final result = PolicyListMetadata.fromJson(mockJsonMap);

      expect(result.date, mockJsonMap['Date']);
      expect(result.documentId, mockJsonMap['DocumentId']);
      expect(result.formDescription, mockJsonMap['FormDescription']);
      expect(result.labelDescription, mockJsonMap['LabelDescription']);
      expect(result.pageNumber, mockJsonMap['PageNumber']);
      expect(result.versionId, mockJsonMap['VersionId']);
    });

    test('toJson should correctly convert PolicyListMetadata to JSON', () {
      final result = policyListMetadata.toJson();

      expect(result, {
        'Date': '2023-08-18',
        'DocumentId': '12345',
        'FormDescription': 'Sample Form',
        'LabelDescription': 'Sample Label',
        'PageNumber': 1,
        'VersionId': 'v1',
      });
    });
  });
}
