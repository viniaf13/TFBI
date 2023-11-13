import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_submission_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'autopay_event.dart';
part 'autopay_state.dart';

class AutopayBloc extends Bloc<AutopayEvent, AutopayState> {
  AutopayBloc({required this.repository}) : super(AutopayInitial()) {
    on<EnrollInAutopay>(
      (event, emit) async {
        try {
          emit(AutopayProcessing());

          final request = AutopaySubmissionRequest.enroll(
            event.policy,
            event.form,
            event.user,
          );

          final response = await repository.updateAutopayConfiguration(request);

          emit(
            response ? AutopaySuccessful() : AutopayFailed(TfbRequestError()),
          );
        } catch (e, stack) {
          final error = TfbRequestError.fromObject(e, stack: stack);
          TfbLogger.exception(
            'Could not enroll in autopay: $e',
            error.exception,
            error.stackTrace,
          );
          emit(AutopayFailed(error));
        }
      },
    );

    on<UpdateAutopay>((event, emit) async {
      try {
        emit(AutopayProcessing());

        emit(
          await repository.updateAutopayConfiguration(
            AutopaySubmissionRequest.update(
              event.policy,
              event.form,
              event.user,
            ),
          )
              ? AutopaySuccessful()
              : AutopayFailed(TfbRequestError()),
        );
      } catch (e, stack) {
        final error = TfbRequestError.fromObject(e, stack: stack);
        TfbLogger.exception(
          'Autopay Configuration Update Failure: $e',
          error.exception,
          error.stackTrace,
        );
        emit(AutopayFailed(error));
      }
    });

    on<DisenrollInAutopay>((event, emit) async {
      try {
        emit(AutopayProcessing());

        emit(
          await repository.updateAutopayConfiguration(
            AutopaySubmissionRequest.disenroll(
              event.policy,
              event.user,
            ),
          )
              ? AutopayDiscontinueSuccess()
              : DiscontinueAutopayFailed(TfbRequestError()),
        );
      } catch (e, stack) {
        final error = TfbRequestError.fromObject(e, stack: stack);
        TfbLogger.exception(
          'Withdrawal from auto pay enrollment failed: $e',
          error.exception,
          error.stackTrace,
        );
        emit(DiscontinueAutopayFailed(error));
      }
    });

    on<CancelledAutopayEnrollment>(
      (event, emit) => emit(AutopayCancelled()),
    );

    on<ResetAutopayBloc>(
      (event, emit) => emit(AutopayInitial()),
    );
  }

  final TfbPolicyLookupRepository repository;
}
