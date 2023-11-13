import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'paperless_lookup_state.dart';

class PaperlessLookupCubit extends Cubit<PaperlessLookupState> {
  PaperlessLookupCubit({
    required TfbPolicyLookupRepository repository,
  })  : _repository = repository,
        super(PaperlessLookupInitState());

  final TfbPolicyLookupRepository _repository;

  Future<void> getPaperlessAccountDetails(
    PolicySummary policy,
  ) async {
    emit(PaperlessLookupProcessingState());

    final PaperlessLookupRequest request = PaperlessLookupRequest(
      memberNumber: policy.memberNumber,
      policyNumber: policy.policyNumber,
      policyType: policy.policyType.value,
    );

    try {
      final PaperlessLookupResponse response =
          await _repository.fetchPaperlessAccountDetails(request);

      _responseIsSuccess(response)
          ? emit(PaperlessLookupSuccessState(response: response))
          : emit(
              PaperlessLookupFailureState(
                error: TfbRequestError(),
              ),
            );
    } catch (error, stack) {
      TfbLogger.exception(
        '[getPaperlessAccountDetails] Error: $error',
        error,
        stack,
      );

      emit(
        PaperlessLookupFailureState(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }

  bool _responseIsSuccess(PaperlessLookupResponse response) =>
      response.errorMessage.isNullOrEmpty &&
      response.memberEmailAddress != 'null' &&
      !response.memberEmailAddress.isNullOrEmpty;
}
