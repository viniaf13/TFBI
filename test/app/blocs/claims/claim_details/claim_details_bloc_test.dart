import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claim_details/claim_details_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/claim_details/claim_details.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';

import '../claims_bloc_test.dart';

void main() {
  late TfbClaimsClientRepository mockClaimsRepository;
  late ClaimDetailsBloc claimsDetailsBloc;

  setUp(() {
    mockClaimsRepository = MockClaimsRepository();
    claimsDetailsBloc = ClaimDetailsBloc(claimsRepo: mockClaimsRepository);
  });

  tearDown(() {
    claimsDetailsBloc.close();
  });

  test('initial state is ClaimDetailsInitState', () {
    expect(
      claimsDetailsBloc.state,
      isA<ClaimDetailsInitState>(),
    );
  });

  blocTest<ClaimDetailsBloc, ClaimDetailsState>(
    'emits [FetchClaimDetailsProcessingState, FetchClaimDetailsSuccess] when GetClaimDetailsEvent is added.',
    setUp: () {
      resetMocktailState();
      when(
        () => mockClaimsRepository.getClaimDetails(
          'claimNumber',
          'policyNumber',
        ),
      ).thenAnswer((_) => Future.value(ClaimDetails()));
    },
    build: () => claimsDetailsBloc,
    act: (bloc) => bloc.add(
      GetClaimDetailsEvent(
        claimNumber: 'claimNumber',
        policyNumber: 'policyNumber',
      ),
    ),
    expect: () => [
      isA<FetchClaimDetailsProcessingState>(),
      isA<FetchClaimDetailsSuccess>(),
    ],
  );

  blocTest<ClaimDetailsBloc, ClaimDetailsState>(
    'emits [FetchClaimDetailsProcessingState, FetchClaimDetailsFailure] when ClaimsInitEvent is added and an error occurs.',
    build: () => claimsDetailsBloc,
    act: (bloc) => bloc.add(
      GetClaimDetailsEvent(
        claimNumber: 'claimNumber',
        policyNumber: 'policyNumber',
      ),
    ),
    expect: () => [
      isA<FetchClaimDetailsProcessingState>(),
      isA<FetchClaimDetailsFailure>(),
    ],
  );
}
