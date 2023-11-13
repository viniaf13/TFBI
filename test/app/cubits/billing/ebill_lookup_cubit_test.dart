import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/ebill_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../../pages/billing/widgets/billing_document_list_container_test.dart';

class MockRepository extends Mock implements TfbPolicyLookupRepository {}

class EbillLookupRequestFake extends Fake implements EbillLookupRequest {}

void main() {
  group('EbillLookupCubit', () {
    late TfbPolicyLookupRepository repository;
    late EbillLookupCubit cubit;
    final mockPolicy = MockPolicySummary();

    setUp(() {
      repository = MockRepository();
      cubit = EbillLookupCubit(repository: repository);
    });

    setUpAll(() {
      registerFallbackValue(EbillLookupRequestFake());
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is EbillLookUpInitState', () {
      expect(cubit.state, equals(EbillLookUpInitState()));
    });

    blocTest<EbillLookupCubit, EbillLookUpState>(
      'emits [ProcessingState, SuccessState] when successful',
      build: () {
        final repository = MockRepository();
        when(() => repository.fetchEbillNotificationDetails(mockPolicy))
            .thenAnswer(
          (_) async => EbillLookupResponse(
            memberPhoneNumber: '1234567890',
          ),
        );
        return EbillLookupCubit(repository: repository);
      },
      act: (cubit) => cubit.getEbillNotificationDetails(mockPolicy),
      expect: () => [
        isA<EbillLookUpProcessingState>(),
        isA<EbillLookUpSuccessState>(),
      ],
    );

    blocTest<EbillLookupCubit, EbillLookUpState>(
      'emits [ProcessingState, FailureState] when error',
      build: () {
        final repository = MockRepository();
        when(() => repository.fetchEbillNotificationDetails(mockPolicy))
            .thenThrow(Exception('error'));
        return EbillLookupCubit(repository: repository);
      },
      act: (cubit) => cubit.getEbillNotificationDetails(mockPolicy),
      expect: () => [
        isA<EbillLookUpProcessingState>(),
        isA<EbillLookUpFailureState>(),
      ],
    );

    blocTest<EbillLookupCubit, EbillLookUpState>(
      'emits [ProcessingState, FailureState] with errorMessage',
      build: () {
        final repository = MockRepository();
        when(() => repository.fetchEbillNotificationDetails(mockPolicy))
            .thenAnswer(
          (_) async => EbillLookupResponse(errorMessage: 'failure'),
        );
        return EbillLookupCubit(repository: repository);
      },
      act: (cubit) => cubit.getEbillNotificationDetails(mockPolicy),
      expect: () => [
        isA<EbillLookUpProcessingState>(),
        isA<EbillLookUpFailureState>(),
      ],
    );
  });
}
