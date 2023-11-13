import 'package:test/test.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';

void main() {
  group('AgentCode', () {
    test('fromJson() should correctly deserialize JSON', () {
      final Map<String, dynamic> json = {
        '_agentCode': 'ABC123',
        '_errorMessage': 'Error message',
      };

      final AgentCode agentCode = AgentCode.fromJson(json);

      expect(agentCode.agentCode, 'ABC123');
      expect(agentCode.errorMessage, 'Error message');
    });

    test('toJson() should correctly serialize to JSON', () {
      final AgentCode agentCode = AgentCode(
        agentCode: 'ABC123',
        errorMessage: 'Error message',
      );

      final Map<String, dynamic> json = agentCode.toJson();

      expect(json['_agentCode'], 'ABC123');
      expect(json['_errorMessage'], 'Error message');
    });

    test('toString() should return the correct string representation', () {
      final AgentCode agentCode = AgentCode(agentCode: 'ABC123');

      final String result = agentCode.toString();

      expect(result, 'Agent Code: ABC123');
    });
  });
}
