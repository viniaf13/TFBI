import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:txfb_insurance_flutter/domain/clients/agent_look_up_client.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';

class MockAgentLookUpClient extends Mock implements AgentLookUpClient {}

class MockAgentCode extends Mock implements AgentCode {}

class MockAgentDetails extends Mock implements AgentDetails {}

void main() {
  late TfbAgentLookupRepository repository;
  late MockAgentLookUpClient mockClient;

  setUp(() {
    mockClient = MockAgentLookUpClient();
    repository = TfbAgentLookupRepository(client: mockClient);
  });

  group('TfbAgentLookupRepository', () {
    test('getAgentCode should return AgentCode when successful', () async {
      const memberNumber = '12345';
      final mockAgentCode = MockAgentCode();
      when(() => mockClient.getAgentCodeByMemberNumber(memberNumber))
          .thenAnswer((_) async => mockAgentCode);

      final result = await repository.getAgentCode(memberNumber);

      expect(result, equals(mockAgentCode));
      verify(() => mockClient.getAgentCodeByMemberNumber(memberNumber))
          .called(1);
    });

    test('getAgentDetails should return AgentDetails when successful',
        () async {
      const agentCode = 'ABC123';
      final mockAgentDetails = MockAgentDetails();
      when(() => mockClient.getAgentDetailsByAgentCode(agentCode))
          .thenAnswer((_) async => mockAgentDetails);

      final result = await repository.getAgentDetails(agentCode);

      expect(result, equals(mockAgentDetails));
      verify(() => mockClient.getAgentDetailsByAgentCode(agentCode)).called(1);
    });
  });
}
