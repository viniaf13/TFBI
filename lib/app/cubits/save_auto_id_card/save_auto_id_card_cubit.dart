import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_delete.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document_repository/tfb_pdf_document_write.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

part 'save_auto_id_card_state.dart';

class SaveAutoIdCardCubit extends Cubit<SaveAutoIdCardState> {
  SaveAutoIdCardCubit({
    required TfbPdfStorageRepository documentRepository,
    required TfbDocumentInformationRepository documentInformationRepository,
    required TfbAutoPolicyDocumentMetadataRepository metadataRepository,
  })  : _documentPdfRepository = documentRepository,
        _documentInformationRepository = documentInformationRepository,
        _metadataRepository = metadataRepository,
        super(const SaveAutoIdCardInitial());

  final TfbPdfStorageRepository _documentPdfRepository;
  final TfbAutoPolicyDocumentMetadataRepository _metadataRepository;
  final TfbDocumentInformationRepository _documentInformationRepository;

  /// Downloads the auto ID card from the API, saves the PDF to local storage,
  /// and saves the document metadata associated with that PDF also in local
  /// storage.
  Future<void> downloadAndSaveAutoIdCard(
    PolicySummary policy,
    AutoPolicyDetail autoPolicyDetail, {
    required bool isTemporary,
    bool showLoadingSnackbar = false,
  }) async {
    try {
      emit(SaveAutoIdCardProcessing(showSnackbar: showLoadingSnackbar));

      // Download the PDF of the insurance card
      final idCardMetadata = await _downloadInsuranceCardPDF(
        policy,
        autoPolicyDetail,
        isTemporary: isTemporary,
      );

      // If the document was successfully downloaded, the PDF saved, and the meta-
      // data saved, then the overall save is success and the card can later
      // be viewed.
      emit(
        SaveAutoIdCardSuccess(
          showSnackbar: showLoadingSnackbar,
          idCardMetadata: idCardMetadata,
        ),
      );
      TfbLogger.debug(
        'Insurance Card with policy number:'
        ' #${idCardMetadata.policyNumber}, was downloaded and marked as'
        ' ${isTemporary ? "temporary" : "cached"}',
      );
    } on Exception catch (e, stack) {
      emit(
        SaveAutoIdCardFailure(
          error: TfbRequestError(
            exception: e,
            stackTrace: stack,
          ),
        ),
      );
    }
  }

  Future<TfbAutoPolicyDocumentMetadata> _downloadInsuranceCardPDF(
    PolicySummary policy,
    AutoPolicyDetail autoPolicy, {
    required bool isTemporary,
  }) async {
    final response =
        await _documentInformationRepository.getAutoIdCardWithTypeAndDate(
      policy.policyNumber,
      policy.policyType.value,
      policy.policyExpirationDate,
    );

    if (response.pages.length != 1) {
      throw Exception(
        'Id card response was empty or contained too many pages',
      );
    }

    /// Save insurance card to application documents directory
    final fileName = _getPolicyFileNameWithoutExtension(policy);

    final tfbAutoPolicyDocumentWrite = TfbPdfFileSave(
      policyBase64: response.pages.first.content,
      fileName: fileName,
    );

    /// If the file is temporary, the file will be saved on TempDirectory
    final pdfFileSavedPath = await _documentPdfRepository.save(
      tfbAutoPolicyDocumentWrite,
      isTemporary: isTemporary,
    );

    /// Save metadata of insurance card, which includes the location of the
    /// actual PDF document, to local storage
    final idCardMetadata = TfbAutoPolicyDocumentMetadata(
      vehicleDisplayTitles:
          autoPolicy.vehicles.map((e) => e.description).toList(),
      expirationDate: DateTime.parse(autoPolicy.expirationDate),
      documentPath: pdfFileSavedPath,
      policyNumber: autoPolicy.policyNumber,
      id: fileName,
      documentIsTemporary: isTemporary,
    );

    await _metadataRepository.save(
      idCardMetadata,
    );

    return idCardMetadata;
  }

  /// Delete a saved PDF and associated metadata from local storage
  Future<void> removeSavedAutoIdCard(
    TfbAutoPolicyDocumentMetadata idCardMetadata, {
    bool fromTemp = false,
  }) async {
    emit(const SaveAutoIdCardProcessing());

    /// First try to remove the metadata associated with the PDF
    ///
    /// This is the most important deletion, and if it doesn't work then return
    /// back to the saved state
    try {
      await _metadataRepository.delete(idCardMetadata.id);
    } catch (e) {
      TfbLogger.exception('Failed to remove saved Auto ID card metadata');
      emit(SaveAutoIdCardFailure(idCardMetadata: idCardMetadata));
      return;
    }

    /// Next try to remove the actual PDF associate with the metadata
    ///
    /// If this fails, it's not a big deal, the user will just have an extra
    /// PDF on their device, but no way to access it because the metadata is
    /// successfully deleted.
    try {
      if (fromTemp) {
        await _documentPdfRepository.deleteFromTemporary();
      } else {
        await _documentPdfRepository.delete(
          TfbPdfFileDelete(fullFilePath: idCardMetadata.documentPath),
        );
      }
      TfbLogger.debug(
        'Insurance Card with policy number:'
        ' #${idCardMetadata.policyNumber}, removed from '
        '${fromTemp ? "temporary directory" : "cached"}',
      );
    } catch (e) {
      TfbLogger.exception(
        'Failed to remove saved Auto ID card PDF, but the metadata was '
        'removed so its alright',
      );
    }

    emit(const SaveAutoIdCardUncached(showSnackbar: true));
  }

  /// Check if a given auto ID card is saved
  /// This method will emit a loading state
  Future<void> getIsIdCardSaved(PolicySummary policySummary) async {
    emit(const SaveAutoIdCardProcessing());
    getSavedCards(policySummary);
  }

  /// Check if a given auto ID card is saved
  Future<void> getSavedCards(PolicySummary policySummary) async {
    final response = await _metadataRepository
        .read(_getPolicyFileNameWithoutExtension(policySummary));

    if (response != null) {
      emit(
        SaveAutoIdCardSuccess(
          idCardMetadata: response,
        ),
      );
    } else {
      emit(const SaveAutoIdCardUncached(showSnackbar: false));
    }
  }

  Future<void> insuranceCardDownload({
    required PolicySummary policySummary,
    required AutoPolicyDetail autoPolicyDetail,
  }) async {
    /// Verify is theres any Insurance Card PDF download as cached for
    /// the current policy
    if (state is SaveAutoIdCardInitial) {
      await getSavedCards(policySummary);
    }

    /// Is the Insurance Card is not download and is not cached, download
    /// the pdf as a temp file
    if (state is SaveAutoIdCardUncached) {
      await downloadAndSaveAutoIdCard(
        policySummary,
        autoPolicyDetail,
        isTemporary: true,
      );
      return;
    }

    /// If the Insurance card is downloaded, and the file is set to be
    /// cached, download the file again. This will update the Insurance
    /// Card to the latest available version
    else if (state is SaveAutoIdCardSuccess) {
      await downloadAndSaveAutoIdCard(
        policySummary,
        autoPolicyDetail,
        isTemporary: false,
      );
    }
    return;
  }

  String _getPolicyFileNameWithoutExtension(PolicySummary policy) =>
      '${policy.policyNumber}-${policy.policyType}-${policy.policyExpirationDate}';
}
