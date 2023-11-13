import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

part 'auto_policy_state.dart';

class AutoPolicyCubit extends Cubit<AutoPolicyState> {
  AutoPolicyCubit({
    required TfbDocumentInformationRepository documentInformationRepository,
  })  : _documentRepository = documentInformationRepository,
        super(AutoPolicyInitial());

  final TfbDocumentInformationRepository _documentRepository;

  Future<void> getPersonalAutoPolicy(PolicySummary policy) async {
    try {
      emit(AutoPolicyProcessing());

      final autoPolicy =
          await _documentRepository.getPersonalSixMonthAutoPolicyAbbreviated(
        policy.policyNumber,
      );

      emit(AutoPolicySuccess(autoPolicyDetail: autoPolicy));
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      TfbLogger.exception(
        'Get auto policy cubit call failed with error:',
        error,
        stack,
      );
      emit(AutoPolicyFailure(error: error));
    }
  }
}
