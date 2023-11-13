import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'routing_number_validation_state.dart';

class RoutingValidationCubit extends Cubit<RoutingValidationState> {
  RoutingValidationCubit({
    required TfbPolicyLookupRepository repository,
  })  : _repository = repository,
        super(RoutingValidationInitState());

  final TfbPolicyLookupRepository _repository;

  void reset() {
    emit(RoutingValidationInitState());
  }

  Future<void> validateRoutingNumber(String routingNumber) async {
    emit(RoutingValidationProcessingState());
    try {
      emit(
        RoutingValidationSuccessState(
          response: await _repository.validateRoutingNumber(routingNumber),
        ),
      );
    } catch (error, trace) {
      TfbLogger.exception(
        '[validateRoutingNumber] Error: $error',
        error,
        trace,
      );

      emit(
        RoutingValidationFailureState(
          error: TfbRequestError.fromObject(error, stack: trace),
        ),
      );
    }
  }
}
