import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/delete_account_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required this.memberAccessClient})
      : super(DeleteAccountInitial());

  final TfbMemberAccessClient memberAccessClient;

  Future<void> deleteAccount(DeleteAccountRequest request) async {
    emit(DeleteAccountProcessing());

    try {
      final response = await memberAccessClient.deleteAccount(request);

      if (response.errorMessage?.isNotEmpty == true) {
        emit(
          DeleteAccountFailed(
            error: TfbRequestError(message: response.errorMessage!),
          ),
        );
      } else {
        emit(DeleteAccountSuccess());
      }
    } catch (e, stack) {
      TfbLogger.exception('Failed to delete account', e, stack);
      final error = TfbRequestError.fromObject(e, stack: stack);
      emit(DeleteAccountFailed(error: error));
    }
  }
}
