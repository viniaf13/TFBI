part of 'auto_policy_document_cubit.dart';

abstract class AutoPolicyDocumentState extends Equatable {
  const AutoPolicyDocumentState();

  @override
  List<Object> get props => [];
}

final class AutoPolicyDocumentInitial extends AutoPolicyDocumentState {}

final class AutoPolicyDocumentProcessing extends AutoPolicyDocumentState {}

final class AutoPolicyDocumentSuccess extends AutoPolicyDocumentState {
  const AutoPolicyDocumentSuccess({
    required this.policyDocuments,
    required this.policyStaticDocuments,
  });

  final List<PolicyListMetadata> policyDocuments;
  final List<PolicyStaticDocument> policyStaticDocuments;

  bool get noDocuments =>
      policyDocuments.isEmpty && policyStaticDocuments.isEmpty;

  @override
  List<Object> get props => [policyDocuments, policyStaticDocuments];
}

class AutoPolicyDocumentError extends AutoPolicyDocumentState {
  const AutoPolicyDocumentError({required this.error});

  final TfbRequestError error;

  @override
  List<Object> get props => [error];
}
