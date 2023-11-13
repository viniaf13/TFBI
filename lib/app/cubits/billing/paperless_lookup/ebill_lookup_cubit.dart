import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'ebill_lookup_state.dart';

class EbillLookupCubit extends Cubit<EbillLookUpState> {
  EbillLookupCubit({
    required TfbPolicyLookupRepository repository,
  })  : _repository = repository,
        super(EbillLookUpInitState());

  final TfbPolicyLookupRepository _repository;

  Future<void> getEbillNotificationDetails(PolicySummary policy) async {
    emit(EbillLookUpProcessingState());

    try {
      final EbillLookupResponse response =
          await _repository.fetchEbillNotificationDetails(policy);

      _responseIsSuccess(response)
          ? emit(EbillLookUpSuccessState(response: response))
          : emit(
              EbillLookUpFailureState(
                error: TfbRequestError(),
              ),
            );
    } catch (error, stack) {
      TfbLogger.exception(
        '[getEbillNotificationDetails] Error: $error',
        error,
        stack,
      );

      emit(
        EbillLookUpFailureState(
          error: TfbRequestError.fromObject(error, stack: stack),
        ),
      );
    }
  }

  bool _responseIsSuccess(EbillLookupResponse response) =>
      response.errorMessage.isNullOrEmpty &&
      response.memberPhoneNumber != 'null' &&
      !response.memberPhoneNumber.isNullOrEmpty;
}
