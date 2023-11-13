import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../paperless_lookup/paperless_lookup_cubit_test.dart';

void main() {
  group('RoutingNumberValidationCubit', () {
    late TfbPolicyLookupRepository repository;
    late RoutingValidationCubit cubit;

    setUp(() {
      repository = MockRepository();
      cubit = RoutingValidationCubit(repository: repository);
    });

    test('initial state is correct', () {
      expect(cubit.state, RoutingValidationInitState());
    });

    blocTest<RoutingValidationCubit, RoutingValidationState>(
      'emits success state on valid number',
      build: () {
        when(() => repository.validateRoutingNumber('123456789'))
            .thenAnswer((_) async => 'data');
        return cubit;
      },
      act: (cubit) => cubit.validateRoutingNumber('123456789'),
      expect: () => [
        isA<RoutingValidationProcessingState>(),
        isA<RoutingValidationSuccessState>(),
      ],
      verify: (_) {
        verify(() => repository.validateRoutingNumber('123456789')).called(1);
      },
    );

    blocTest<RoutingValidationCubit, RoutingValidationState>(
      'emits failure state on error',
      build: () {
        when(() => repository.validateRoutingNumber(any()))
            .thenThrow(TfbRequestError());
        return cubit;
      },
      act: (cubit) => cubit.validateRoutingNumber('invalid'),
      expect: () => [
        isA<RoutingValidationProcessingState>(),
        isA<RoutingValidationFailureState>(),
      ],
    );
  });
}
