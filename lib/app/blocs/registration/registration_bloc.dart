import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/secure_registration_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required this.repository})
      : super(const RegistrationInitState()) {
    on<RegistrationSubmitEvent>(_registerUser);
    on<RegistrationFormCompletedEvent>(_readyToSubmitRegistration);
  }

  final TfbMemberRegistrationRepository repository;

  Future<void> _registerUser(
    RegistrationSubmitEvent event,
    Emitter<RegistrationState> emitter,
  ) async {
    try {
      emitter(RegistrationProcessingState());
      final result = await repository.registerUser(event.request);
      if (result.errorMessage != null) {
        emitter(
          RegistrationFailureState(
            error: TfbRequestError(message: result.errorMessage!),
          ),
        );
      } else {
        emitter(RegistrationSuccessState(request: event.request));
      }
    } catch (e, stackTrace) {
      final error = TfbRequestError.fromObject(e, stack: stackTrace);
      TfbLogger.exception(
        'Error registering user in registration_bloc',
        error.exception,
        error.stackTrace,
      );
      emitter(RegistrationFailureState(error: error));
    }
  }

  Future<void> _readyToSubmitRegistration(
    RegistrationFormCompletedEvent event,
    Emitter<RegistrationState> emitter,
  ) async {
    emitter(RegistrationShouldSubmitState());
  }
}
