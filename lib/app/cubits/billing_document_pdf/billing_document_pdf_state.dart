part of 'billing_document_pdf_cubit.dart';

sealed class BillingDocumentPdfState extends Equatable {
  const BillingDocumentPdfState();

  @override
  List<Object> get props => [];
}

final class BillingDocumentPdfInitial extends BillingDocumentPdfState {}

final class BillingDocumentPdfProcessing extends BillingDocumentPdfState {}

final class BillingDocumentPdfError extends BillingDocumentPdfState {
  const BillingDocumentPdfError(this.error);

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}

final class BillingDocumentPdfSuccess extends BillingDocumentPdfState {
  const BillingDocumentPdfSuccess(this.filePath);

  final String filePath;

  @override
  List<Object> get props => [filePath];
}
