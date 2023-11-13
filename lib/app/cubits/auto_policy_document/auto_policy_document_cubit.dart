import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_documents_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'auto_policy_document_state.dart';

class AutoPolicyDocumentCubit extends Cubit<AutoPolicyDocumentState> {
  AutoPolicyDocumentCubit({
    required TfbDocumentInformationRepository documentInformationRepository,
  })  : _documentInformationRepository = documentInformationRepository,
        super(AutoPolicyDocumentInitial());

  final TfbDocumentInformationRepository _documentInformationRepository;

  Future<void> getPolicyDocumentList(PolicySummary policy) async {
    try {
      emit(AutoPolicyDocumentProcessing());

      final requestDocuments = PolicyListRequest.fromPolicySummary(policy);

      final policyDocuments = await _documentInformationRepository
          .getPolicyDocuments(policy.policyNumber, requestDocuments);

      final requestStaticDocuments = PolicyStaticDocumentsRequest.fromRequest(
        policy,
      );

      final policyStaticDocument =
          await _documentInformationRepository.getPolicyStaticDocuments(
        requestStaticDocuments,
      );

      emit(
        AutoPolicyDocumentSuccess(
          policyDocuments: policyDocuments,
          policyStaticDocuments: policyStaticDocument,
        ),
      );
    } on Exception catch (error, stack) {
      TfbLogger.exception(
        'Failure to get auto policy document list',
        error,
        stack,
      );

      emit(
        AutoPolicyDocumentError(
          error: TfbRequestError(
            exception: error,
            stackTrace: stack,
          ),
        ),
      );
    }
  }
}
