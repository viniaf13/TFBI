import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_submission_request.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../../../mocks/mock_tfb_policy_lookup_repository.dart';
import '../../cubits/auto_policy_document/auto_policy_document_cubit_test.dart';
import '../../pages/dashboard/support_agent/support_section_test.dart';

void main() {
  late TfbPolicyLookupRepository mockLookupRepository;

  setUp(() {
    mockLookupRepository = MockTfbPolicyLookupRepository();

    registerFallbackValue(emptyAutopayUpdateRequest);
  });

  blocTest<AutopayBloc, AutopayState>(
    'AutoPay bloc emits processing then success state on successful autopay enrollment',
    setUp: () {
      when(() => mockLookupRepository.updateAutopayConfiguration(any()))
          .thenAnswer((invocation) async => true);
    },
    build: () => AutopayBloc(repository: mockLookupRepository),
    act: (bloc) => bloc.add(
      EnrollInAutopay(
        policy: testPolicySummary,
        form: emptyAutopayFormState,
        user: testUser,
      ),
    ),
    expect: () => [isA<AutopayProcessing>(), isA<AutopaySuccessful>()],
  );

  blocTest<AutopayBloc, AutopayState>(
    'AutoPay bloc emits processing then failed state when the autopay repository throws an exception',
    setUp: () {
      when(() => mockLookupRepository.updateAutopayConfiguration(any()))
          .thenThrow(Exception('Failed...'));
    },
    build: () => AutopayBloc(repository: mockLookupRepository),
    act: (bloc) => bloc.add(
      EnrollInAutopay(
        policy: testPolicySummary,
        form: emptyAutopayFormState,
        user: testUser,
      ),
    ),
    expect: () => [isA<AutopayProcessing>(), isA<AutopayFailed>()],
  );

  blocTest<AutopayBloc, AutopayState>(
    'AutoPay bloc emits processing then failed state when the update autopay response returns false',
    setUp: () {
      when(() => mockLookupRepository.updateAutopayConfiguration(any()))
          .thenAnswer((invocation) async => false);
    },
    build: () => AutopayBloc(repository: mockLookupRepository),
    act: (bloc) => bloc.add(
      EnrollInAutopay(
        policy: testPolicySummary,
        form: emptyAutopayFormState,
        user: testUser,
      ),
    ),
    expect: () => [isA<AutopayProcessing>(), isA<AutopayFailed>()],
  );

  blocTest<AutopayBloc, AutopayState>(
    'AutoPay bloc emits disenroll failure then failed state when the disenroll fails',
    setUp: () {
      when(() => mockLookupRepository.updateAutopayConfiguration(any()))
          .thenAnswer((invocation) async => false);
    },
    build: () => AutopayBloc(repository: mockLookupRepository),
    act: (bloc) => bloc.add(
      DisenrollInAutopay(
        policy: testPolicySummary,
        user: testUser,
      ),
    ),
    expect: () => [isA<AutopayProcessing>(), isA<DiscontinueAutopayFailed>()],
  );
}

final emptyAutopayUpdateRequest = AutopaySubmissionRequest(
  accountType: AutopayAccountType.unknown,
  agentId: '',
  bankAccountNumber: '',
  bankName: '',
  bankRoutingNumber: '',
  effectiveDate: '',
  insuredEmailAddress: '',
  memberNumber: '',
  paymentDate: 0,
  policyNumber: '',
  policySubType: '',
  policyType: '',
  policyholderName: '',
  requestType: AutopayRequestType.unknown,
);

final emptyAutopayFormState = AutopayFormState(
  nameOnBankAccount: '',
  accountType: AutopayAccountType.unknown,
  bankRoutingNumber: '',
  bankAccountNumber: '',
  bankName: '',
  paymentDate: 0,
);
