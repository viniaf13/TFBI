import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../../../pages/billing/widgets/billing_document_list_container_test.dart';

class MockRepository extends Mock implements TfbPolicyLookupRepository {}

class PaperlessLookupRequestFake extends Fake
    implements PaperlessLookupRequest {}

void main() {
  group('PaperlessLookupCubit', () {
    late TfbPolicyLookupRepository repository;
    late PaperlessLookupCubit cubit;
    final mockPolicy = MockPolicySummary();

    setUp(() {
      repository = MockRepository();
      cubit = PaperlessLookupCubit(repository: repository);
      when(() => mockPolicy.memberNumber).thenReturn('123');
      when(() => mockPolicy.policyNumber).thenReturn('456');
      when(() => mockPolicy.policyType).thenReturn(PolicyType.txPersonalAuto);
    });

    setUpAll(() {
      registerFallbackValue(PaperlessLookupRequestFake());
    });

    tearDown(() {
      cubit.close();
    });

    test('has correct initial state', () {
      expect(cubit.state, PaperlessLookupInitState());
    });

    blocTest<PaperlessLookupCubit, PaperlessLookupState>(
      'emits processing then success state on success',
      build: () {
        final repository = MockRepository();
        when(() => repository.fetchPaperlessAccountDetails(any())).thenAnswer(
          (_) async =>
              PaperlessLookupResponse(memberEmailAddress: 'test@test.co'),
        );
        return PaperlessLookupCubit(repository: repository);
      },
      act: (cubit) => cubit.getPaperlessAccountDetails(mockPolicy),
      expect: () => [
        isA<PaperlessLookupProcessingState>(),
        isA<PaperlessLookupSuccessState>(),
      ],
    );

    blocTest<PaperlessLookupCubit, PaperlessLookupState>(
      'emits processing then failure state on error',
      build: () {
        final repository = MockRepository();
        when(() => repository.fetchPaperlessAccountDetails(any()))
            .thenThrow(Exception());
        return PaperlessLookupCubit(repository: repository);
      },
      act: (cubit) => cubit.getPaperlessAccountDetails(mockPolicy),
      expect: () => [
        isA<PaperlessLookupProcessingState>(),
        isA<PaperlessLookupFailureState>(),
      ],
    );
  });
}
