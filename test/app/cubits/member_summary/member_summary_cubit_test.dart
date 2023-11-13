import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/policy_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary_response.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';

import '../../../mocks/mock_policy_lookup_client.dart';

void main() {
  late TfbPolicyLookupClient mockPolicyLookupClient;

  setUp(() {
    mockPolicyLookupClient = MockPolicyLookupClient();
  });

  test('member summary cubit starts in the [MemberSummaryInitial] state',
      () async {
    expect(
      MemberSummaryCubit(
        repository: TfbPolicyLookupRepository(
          client: mockPolicyLookupClient,
          accessToken: '',
        ),
      ).state,
      isA<MemberSummaryInitial>(),
    );
  });

  blocTest<MemberSummaryCubit, MemberSummaryState>(
    'If the member summary call fails, then the member summary cubit should move to the [MemberSummaryFailure] state',
    build: () => MemberSummaryCubit(
      repository: TfbPolicyLookupRepository(
        client: mockPolicyLookupClient,
        accessToken: '',
      ),
    ),
    setUp: () {
      when(() => mockPolicyLookupClient.getMemberSummary(any()))
          .thenThrow(Exception());
    },
    act: (bloc) => bloc.getMemberSummary(),
    expect: () => [isA<MemberSummaryProcessing>(), isA<MemberSummaryFailure>()],
  );

  blocTest<MemberSummaryCubit, MemberSummaryState>(
    'If the member summary call fails, then the member summary cubit should move to the [MemberSummaryFailure] state',
    build: () => MemberSummaryCubit(
      repository: TfbPolicyLookupRepository(
        client: mockPolicyLookupClient,
        accessToken: '',
      ),
    ),
    setUp: () {
      when(() => mockPolicyLookupClient.getMemberSummary(any())).thenAnswer(
        (invocation) => Future.value(MemberSummaryResponse(policies: [])),
      );
    },
    act: (bloc) => bloc.getMemberSummary(),
    expect: () => [
      isA<MemberSummaryProcessing>(),
      isA<MemberSummarySuccess>(),
      isA<MemberSummaryDetailsSuccess>(),
    ],
  );
}
