import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit({required this.memberRegistrationRepository})
      : super(EmailVerificationInitial());

  final TfbMemberRegistrationRepository memberRegistrationRepository;

  Future<void> verifyEmail(String validationCode) async {
    try {
      emit(EmailVerificationProcessing());
      final response =
          await memberRegistrationRepository.verifyEmail(validationCode);
      if (response.errorMessage?.isNotEmpty == true) {
        emit(
          EmailVerificationError(
            error: TfbRequestError(message: response.errorMessage!),
          ),
        );
      } else {
        emit(EmailVerificationSuccess());
      }
    } catch (e, stackTrace) {
      final error = TfbRequestError.fromObject(
        e,
        stack: stackTrace,
        defaultMessage: 'Please try again later.',
      );
      TfbLogger.warning(
        'Error verifying email in email verification cubit.',
        error.exception,
        error.stackTrace,
      );
      emit(EmailVerificationError(error: error));
    }
  }
}
