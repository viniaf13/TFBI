import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/forgot_password/update_member_secure_password_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required TfbMemberAccessClient memberAccessClient})
      : _memberAccessClient = memberAccessClient,
        super(ChangePasswordInitial());

  final TfbMemberAccessClient _memberAccessClient;

  Future<void> submitChangedPassword(
    ChangePasswordSubmission changePasswordSubmission,
  ) async {
    emit(ChangePasswordProcessing());

    try {
      final updateResponse =
          await _memberAccessClient.updateMemberSecurePassword(
        UpdateMemberSecurePasswordRequest(
          memberId: 0,
          membershipArray: changePasswordSubmission.membershipArray,
          newPassword: changePasswordSubmission.password,
          userName: changePasswordSubmission.emailAddress,
        ),
      );

      if (updateResponse.errorMessage?.isNotEmpty == true) {
        emit(
          ChangePasswordFailure(
            error: TfbRequestError(message: updateResponse.errorMessage!),
          ),
        );
        return;
      }
      emit(ChangePasswordSuccess());
    } catch (e, stackTrace) {
      final error = TfbRequestError.fromObject(e, stack: stackTrace);
      TfbLogger.warning(
        'Submit updated password called failed in cubit',
        error,
        stackTrace,
      );
      emit(ChangePasswordFailure(error: error));
    }
  }
}

class ChangePasswordSubmission {
  ChangePasswordSubmission({
    required this.membershipArray,
    required this.emailAddress,
    required this.password,
  });

  List<String> membershipArray;
  String emailAddress;
  String password;
}
