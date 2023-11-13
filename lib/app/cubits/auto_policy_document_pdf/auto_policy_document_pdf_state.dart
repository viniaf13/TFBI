part of 'auto_policy_document_pdf_cubit.dart';

abstract class AutoPolicyDocumentPdfState extends Equatable {
  const AutoPolicyDocumentPdfState();

  @override
  List<Object?> get props => [];
}

final class AutoPolicyDocumentPdfInitial extends AutoPolicyDocumentPdfState {}

final class AutoPolicyDocumentPdfProcessing
    extends AutoPolicyDocumentPdfState {}

final class AutoPolicyDocumentPdfSuccess extends AutoPolicyDocumentPdfState {
  const AutoPolicyDocumentPdfSuccess({
    required this.filePath,
    this.documentMetadata,
  });

  final PdfDocumentMetadata? documentMetadata;
  final String filePath;

  @override
  List<Object?> get props => [documentMetadata, filePath];
}

class AutoPolicyDocumentPdfError extends AutoPolicyDocumentPdfState {
  const AutoPolicyDocumentPdfError({required this.error});

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
