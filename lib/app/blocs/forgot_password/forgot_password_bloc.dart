import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required this.memberAccessClient, String? email})
      : super(
          email != null
              ? ForgotPasswordRequestSuccess(email)
              : ForgotPasswordInitial(),
        ) {
    on<RequestForgotPasswordEvent>(_requestForgotPassword);
  }

  final TfbMemberAccessClient memberAccessClient;

  Future<void> _requestForgotPassword(
    RequestForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    try {
      emit(ForgotPasswordRequestProcessing());
      final response = await memberAccessClient.forgotPassword(event.email);
      final errorMessage = response.errorMessage;
      if (errorMessage != null && errorMessage.isNotEmpty) {
        emit(
          ForgotPasswordRequestError(
            error: TfbRequestError(message: errorMessage),
          ),
        );
      } else {
        emit(ForgotPasswordRequestSuccess(event.email));
      }
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      TfbLogger.exception(
        'Forgot password called failed with email ${event.email}:',
        error.exception,
        error.stackTrace,
      );
      emit(ForgotPasswordRequestError(error: error));
    }
  }
}
