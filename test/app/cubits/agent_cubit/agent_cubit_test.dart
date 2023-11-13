import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

class MockTfbAgentLookupRepository extends Mock
    implements TfbAgentLookupRepository {}

class MockAgentCode extends Mock implements AgentCode {}

class MockAgentDetails extends Mock implements AgentDetails {}

void main() {
  group('AgentCubit', () {
    late AgentCubit agentCubit;
    late MockTfbAgentLookupRepository mockRepository;

    setUp(() {
      mockRepository = MockTfbAgentLookupRepository();
      agentCubit = AgentCubit(repository: mockRepository);
    });

    tearDown(() {
      agentCubit.close();
    });

    test('initial state should be AgentInitial', () {
      // Assert
      expect(agentCubit.state, equals(AgentInitial()));
    });

    blocTest<AgentCubit, AgentState>(
      'getAgent emits AgentProcessing and AgentCodeSuccess when memberNumber is empty',
      build: () => agentCubit,
      act: (cubit) async {
        final mockAgentCode = MockAgentCode();

        when(() => mockRepository.getAgentCode(any()))
            .thenAnswer((_) async => mockAgentCode);
        when(() => mockAgentCode.agentCode).thenReturn('ABC123');
        when(() => mockRepository.getAgentDetails(any()))
            .thenThrow(TfbRequestError(message: ''));

        await cubit.getAgent('123');
      },
      expect: () => [
        isA<AgentProcessing>(),
        isA<AgentFailure>(),
      ],
    );

    blocTest<AgentCubit, AgentState>(
      'getAgent emits AgentProcessing and AgentDetailsSuccess when memberNumber is not empty',
      build: () => agentCubit,
      act: (cubit) async {
        final mockAgentCode = MockAgentCode();
        final mockAgentDetails = MockAgentDetails();

        when(() => mockRepository.getAgentCode(any()))
            .thenAnswer((_) async => mockAgentCode);
        when(() => mockAgentCode.agentCode).thenReturn('ABC123');
        when(() => mockRepository.getAgentDetails(any()))
            .thenAnswer((_) async => mockAgentDetails);

        await cubit.getAgent('12345');
      },
      expect: () => [
        isA<AgentProcessing>(),
        isA<AgentDetailsSuccess>(),
      ],
    );
  });
}
