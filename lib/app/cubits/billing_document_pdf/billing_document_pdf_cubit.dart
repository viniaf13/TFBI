import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_document_version_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';

part 'billing_document_pdf_state.dart';

class BillingDocumentPdfCubit extends Cubit<BillingDocumentPdfState> {
  BillingDocumentPdfCubit({
    required this.client,
    required this.documentPdfRepository,
  }) : super(BillingDocumentPdfInitial());

  final TfbDocumentInformationClient client;
  final TfbPdfStorageRepository documentPdfRepository;

  Future<void> getBillingDocument(
    PolicySummary policy,
    BillingListMetadata billingListMetadata,
  ) async {
    try {
      emit(BillingDocumentPdfProcessing());

      final billingDocumentResponse = await client.getBillingDocumentByVersion(
        policy.policyNumber,
        BillingDocumentVersionRequest.fromPolicyVersionAndDescription(
          billingListMetadata.versionId,
          policy,
          billingListMetadata.formDescription,
        ),
      );

      if (billingDocumentResponse.pages.length != 1) {
        throw Exception(
          'Id card response was empty or contained too many pages',
        );
      }

      final fileName =
          '${policy.policyNumber}-${billingListMetadata.versionId}';

      final savedFilePath = await documentPdfRepository.save(
        TfbPdfFileSave(
          policyBase64: billingDocumentResponse.pages.first.content,
          fileName: fileName,
        ),
      );

      emit(BillingDocumentPdfSuccess(savedFilePath));
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      emit(BillingDocumentPdfError(error));
    }
  }
}
