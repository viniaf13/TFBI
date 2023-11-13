import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/policy_lookup_exception.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'member_summary_state.dart';

class MemberSummaryCubit extends Cubit<MemberSummaryState> {
  MemberSummaryCubit({required this.repository})
      : super(MemberSummaryInitial());

  final TfbPolicyLookupRepository repository;

  Future<void> getMemberSummary({bool isPullToRefresh = false}) async {
    try {
      emit(MemberSummaryProcessing(isPullToRefresh: isPullToRefresh));

      final summary = await repository.getMemberSummary();
      emit(MemberSummarySuccess(memberSummary: summary));
      final policyMap =
          await repository.getPolicyDetails(summary.supportedPolicies);

      emit(
        MemberSummaryDetailsSuccess(
          memberSummary: summary,
          policyMap: policyMap,
        ),
      );
    } catch (e, stack) {
      // Catch block for member details, which throws an error, and
      // any successful responses. Any one of home/auto/farm may error
      // independently.
      TfbRequestError error;
      if ((e is (dynamic, dynamic)) && (e.$2 != null)) {
        final (TfbRequestError, Map<String, PolicyDetail>) partialSuccess =
            e as (TfbRequestError, Map<String, PolicyDetail>);
        error = e.$1;
        if (state is MemberSummarySuccess) {
          emit(
            MemberSummaryDetailsSuccess(
              memberSummary: (state as MemberSummarySuccess).memberSummary,
              policyMap: partialSuccess.$2,
              error: error,
            ),
          );
        }
      } else if (e is PolicyLookupException) {
        error = TfbRequestError.fromObject(
          e,
          stack: stack,
          defaultMessage: e.errorMessage,
        );
        emit(
          MemberSummaryDetailsSuccess(
            memberSummary: MemberSummary(policies: []),
            policyMap: const {},
            error: error,
          ),
        );
      } else {
        // Catch block for member summary API
        error = TfbRequestError.fromObject(e, stack: stack);
        TfbLogger.exception(
          'Get member summary call failed with error:',
          error,
          stack,
        );
        emit(MemberSummaryFailure(error: error));
      }
    }
  }
}
