import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

class MockMemberSummaryCubit extends MockCubit<MemberSummaryState>
    implements MemberSummaryCubit {
  @override
  Future<void> getMemberSummary({bool isPullToRefresh = false}) async {}
}

class FakeMemberSummaryState extends Fake implements MemberSummaryState {}

final mockMemberSummaryInitial = MemberSummaryInitial();

final mockMemberSummaryFailure = MemberSummaryFailure(
  error: TfbRequestError(message: 'Mock error'),
);

final mockMemberSummaryDetailsSuccessWithError = MemberSummaryDetailsSuccess(
  memberSummary: MemberSummary(
    policies: const [],
  ),
  policyMap: const {},
  error: TfbRequestError(message: 'Mock error'),
);
