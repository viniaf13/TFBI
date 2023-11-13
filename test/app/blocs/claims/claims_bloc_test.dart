import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claims.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

class MockClaimsRepository extends Mock implements TfbClaimsClientRepository {}

class MockLogger extends Mock implements TfbLogger {}

void main() {
  group('ClaimsBloc', () {
    late TfbClaimsClientRepository mockClaimsRepository;
    late ClaimsBloc claimsBloc;

    setUp(() {
      mockClaimsRepository = MockClaimsRepository();
      claimsBloc = ClaimsBloc(claimsRepository: mockClaimsRepository);
    });

    tearDown(() {
      claimsBloc.close();
    });

    test('initial state is ClaimsInitState', () {
      expect(
        claimsBloc.state,
        isA<ClaimsInitState>(),
      );
    });

    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsProcessingState, ClaimsSuccessState] when ClaimsInitEvent is added.',
      setUp: () {
        resetMocktailState();
        when(() => mockClaimsRepository.getAllMemberClaims('memberNumber'))
            .thenAnswer((_) => Future.value(ClaimsList(claims: [])));
      },
      build: () => claimsBloc,
      act: (bloc) => bloc.add(ClaimsInitEvent('memberNumber')),
      expect: () => [
        isA<ClaimsProcessingState>(),
        isA<ClaimSuccessState>(),
      ],
    );

    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsProcessingState, ClaimsFailureState] when ClaimsInitEvent is added and an error occurs.',
      build: () => claimsBloc,
      act: (bloc) => bloc.add(ClaimsInitEvent('memberNumber')),
      expect: () => [
        isA<ClaimsProcessingState>(),
        isA<ClaimsFailureState>(),
      ],
    );

    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsProcessingState] and state.isPullToRefresh is False',
      build: () => claimsBloc,
      act: (bloc) => bloc.add(ClaimsInitEvent('memberNumber')),
      expect: () => [
        isA<ClaimsProcessingState>()
            .having((state) => state.isPullToRefresh, 'isPullToRefresh', false),
        isA<ClaimsFailureState>(),
      ],
    );

    blocTest<ClaimsBloc, ClaimsState>(
      'emits [ClaimsProcessingState] and state.isPullToRefresh is True',
      build: () => claimsBloc,
      act: (bloc) => bloc.add(
        ClaimsInitEvent(
          'memberNumber',
          isPullToRefresh: true,
        ),
      ),
      expect: () => [
        isA<ClaimsProcessingState>()
            .having((state) => state.isPullToRefresh, 'isPullToRefresh', true),
        isA<ClaimsFailureState>(),
      ],
    );
  });
}
