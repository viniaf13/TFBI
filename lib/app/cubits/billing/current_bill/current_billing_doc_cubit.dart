import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_request.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'current_billing_doc_state.dart';

class CurrentBillingDocCubit extends Cubit<CurrentBillingDocState> {
  CurrentBillingDocCubit({
    required TfbPdfStorageRepository documentPdfRepository,
    required TfbDocumentInformationRepository documentRepository,
  })  : _documentPdfRepository = documentPdfRepository,
        _documentRepository = documentRepository,
        super(CurrentBillingDocInitState());

  final TfbPdfStorageRepository _documentPdfRepository;
  final TfbDocumentInformationRepository _documentRepository;

  Future<void> fetchCurrentBillingDocument(
    PolicySummary policy,
  ) async {
    final request = BillingRequest.fromPolicySummary(policy);

    try {
      emit(CurrentBillingDocProcessingState());

      final response =
          await _documentRepository.getCurrentBillingDocument(request);

      if (response.pages.isNullOrEmpty) {
        emit(CurrentBillingDocFailureState(error: TfbRequestError()));
        throw Exception(
          '[CurrentBillingDocCubit] Current Bill response was empty or contained too many pages',
        );
      } else {
        final fileName = _getCurrentBillFileName(request.policyNumber);

        final filePath = await _documentPdfRepository.save(
          TfbPdfFileSave(
            policyBase64: response.pages.first.content,
            fileName: fileName,
          ),
        );

        emit(CurrentBillingDocSuccessState(filePath: filePath));
      }
    } catch (error, stack) {
      emit(
        CurrentBillingDocFailureState(
          error: TfbRequestError(stackTrace: stack),
        ),
      );
    }
  }

  String _getCurrentBillFileName(String policyNumber) =>
      'farm_bureau-$policyNumber-${_getDateStringForFileName()}';

  String _getDateStringForFileName() {
    final now = DateTime.now();
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString();

    return '$month$year';
  }
}
