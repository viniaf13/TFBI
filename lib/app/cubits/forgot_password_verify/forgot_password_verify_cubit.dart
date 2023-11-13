import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/forgot_password_verify_request.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/update_member_secure_password_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'forgot_password_verify_state.dart';

class ForgotPasswordVerifyCubit extends Cubit<ForgotPasswordVerifyState> {
  ForgotPasswordVerifyCubit({required TfbMemberAccessClient memberAccessClient})
      : _memberAccessClient = memberAccessClient,
        super(ForgotPasswordVerifyInitial());

  final TfbMemberAccessClient _memberAccessClient;

  Future<void> submitUpdatedPassword(
    UpdatedPasswordSubmission updatedPasswordSubmission,
  ) async {
    emit(ForgotPasswordVerifyProcessing());

    try {
      final response = await _memberAccessClient.verifyForgotPasswordEmail(
        ForgotPasswordVerifyRequest(
          emailAddress: updatedPasswordSubmission.emailAddress,
          verificationCode: updatedPasswordSubmission.verificationCode,
        ),
      );

      if (response.errorMessage?.isNotEmpty == true) {
        emit(
          ForgotPasswordVerifyFailure(
            error: TfbRequestError(
              message: response.errorMessage ?? kGeneralApiFailure,
            ),
          ),
        );
        return;
      }

      final updateResponse =
          await _memberAccessClient.updateMemberSecurePassword(
        UpdateMemberSecurePasswordRequest(
          memberId: 0,
          membershipArray: response.membershipArray!,
          newPassword: updatedPasswordSubmission.password,
          userName: updatedPasswordSubmission.emailAddress,
        ),
      );

      if (updateResponse.errorMessage?.isNotEmpty == true) {
        emit(
          ForgotPasswordVerifyFailure(
            error: TfbRequestError(message: updateResponse.errorMessage!),
          ),
        );
        return;
      }

      emit(ForgotPasswordVerifySuccess());
    } catch (e, stackTrace) {
      final error = TfbRequestError.fromObject(e, stack: stackTrace);
      TfbLogger.warning(
        'Submit updated password called failed in cubit',
        error,
        stackTrace,
      );
      emit(ForgotPasswordVerifyFailure(error: error));
    }
  }
}

class UpdatedPasswordSubmission {
  UpdatedPasswordSubmission({
    required this.emailAddress,
    required this.verificationCode,
    required this.password,
  });

  String emailAddress;
  String verificationCode;
  String password;
}
