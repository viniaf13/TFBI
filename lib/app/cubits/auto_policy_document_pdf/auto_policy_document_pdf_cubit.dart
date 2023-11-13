import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_document_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'auto_policy_document_pdf_state.dart';

class AutoPolicyDocumentPdfCubit extends Cubit<AutoPolicyDocumentPdfState> {
  AutoPolicyDocumentPdfCubit({
    required TfbDocumentInformationRepository documentInformationRepository,
    required TfbPdfStorageRepository documentPdfRepository,
  })  : _documentInformationRepository = documentInformationRepository,
        _documentPdfRepository = documentPdfRepository,
        super(AutoPolicyDocumentPdfInitial());

  final TfbDocumentInformationRepository _documentInformationRepository;
  final TfbPdfStorageRepository _documentPdfRepository;

  Future<void> getPolicyDocumentMetadata(
    PolicySummary policy,
    PolicyListMetadata document,
  ) async {
    try {
      emit(AutoPolicyDocumentPdfProcessing());

      final request = PolicyDocumentRequest.fromPolicySummary(
        policy,
        document.documentId,
      );

      final documentMetadata =
          await _documentInformationRepository.getPolicyDocumentMetadata(
        policy.policyNumber,
        request,
      );

      final fileName = _getPolicyDocumentName(
        policy.policyNumber,
        document.labelDescription,
      );

      final filePath = await _documentPdfRepository.save(
        TfbPdfFileSave(
          policyBase64: documentMetadata.pages.first.content,
          fileName: fileName,
        ),
        isTemporary: true,
      );

      emit(
        AutoPolicyDocumentPdfSuccess(
          documentMetadata: documentMetadata,
          filePath: filePath,
        ),
      );
    } on Exception catch (error, stack) {
      TfbLogger.exception(
        'Failure to get auto policy document pdf metadata',
        error,
        stack,
      );

      emit(
        AutoPolicyDocumentPdfError(
          error: TfbRequestError(
            exception: error,
            stackTrace: stack,
          ),
        ),
      );
    }
  }

  Future<void> getStaticPolicyDocumentMetadata(
    PolicySummary policy,
    String documentUrl,
    String documentName,
  ) async {
    try {
      emit(AutoPolicyDocumentPdfProcessing());

      final fileName = _getPolicyDocumentName(
        policy.policyNumber,
        documentName,
      );

      final filePath = await _documentPdfRepository.downloadPdfTemp(
        documentUrl,
        fileName,
      );

      emit(
        AutoPolicyDocumentPdfSuccess(
          filePath: filePath,
        ),
      );
    } on Exception catch (error, stack) {
      TfbLogger.exception(
        'Failure to get auto policy static document pdf metadata',
        error,
        stack,
      );

      emit(
        AutoPolicyDocumentPdfError(
          error: TfbRequestError(
            exception: error,
            stackTrace: stack,
          ),
        ),
      );
    }
  }

  Future<void> deletePolicyDocumentsFromTemporary() async {
    try {
      await _documentPdfRepository.deleteFromTemporary();
    } on Exception catch (error, stack) {
      TfbLogger.exception(
        'Failure to remove auto policy document temporary file',
        error,
        stack,
      );
    }
  }

  String _getPolicyDocumentName(String policyNumber, String documentLabel) =>
      'farm_bureau-$policyNumber-${documentLabel.replaceAll('/', '-')}';
}
