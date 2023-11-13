import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'registration_resend_state.dart';

class RegistrationResendCubit extends Cubit<RegistrationResendState> {
  RegistrationResendCubit(this.authClient) : super(RegistrationResendInitial());

  TfbMemberAccessClient authClient;

  bool _isProcessing = false;

  Future<void> resendRegistration(RegistrationResendRequest request) async {
    if (_isProcessing) return;

    _isProcessing = true;
    emit(RegistrationResendProcessing());

    try {
      final response = await authClient.registerResend(request);
      if (response.errorMessage?.isNotEmpty == true) {
        emit(
          RegistrationResendError(
            TfbRequestError(message: response.errorMessage!),
          ),
        );
      } else {
        emit(RegistrationResendSuccess());
      }
    } catch (e, stackTrace) {
      final error = TfbRequestError.fromObject(e, stack: stackTrace);
      TfbLogger.exception(
        'Error with registration resend API call',
        error.exception,
        error.stackTrace,
      );
      emit(RegistrationResendError(error));
    }

    _isProcessing = false;
  }
}
