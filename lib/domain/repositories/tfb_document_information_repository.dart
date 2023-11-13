import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_request.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_document_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_documents_request.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class TfbDocumentInformationRepository {
  TfbDocumentInformationRepository({
    required TfbDocumentInformationClient client,
  }) : _client = client;

  final TfbDocumentInformationClient _client;

  Future<PdfDocumentMetadata> getAutoIdCardWithTypeAndDate(
    String policyNumber,
    String policyType,
    String expirationDate,
  ) =>
      _client.getAutoIdCardWithTypeAndDate(
        policyNumber,
        policyType,
        expirationDate,
      );

  Future<AutoPolicyDetail> getPersonalSixMonthAutoPolicyAbbreviated(
    String policyNumber,
  ) =>
      _client.getPersonalSixMonthAutoPolicyAbbreviated(policyNumber);

  Future<PdfDocumentMetadata> getPolicyDocumentMetadata(
    String policyNumber,
    PolicyDocumentRequest policyDocumentRequest,
  ) =>
      _client.getPolicyDocumentMetadata(
        policyNumber,
        policyDocumentRequest,
      );

  Future<List<PolicyListMetadata>> getPolicyDocuments(
    String policyNumber,
    PolicyListRequest policyListRequest,
  ) =>
      _client.getPolicyDocuments(
        policyNumber,
        policyListRequest,
      );

  Future<List<PolicyStaticDocument>> getPolicyStaticDocuments(
    PolicyStaticDocumentsRequest policyStaticDocumentsRequest,
  ) =>
      _client.getPolicyStaticDocuments(policyStaticDocumentsRequest);

  Future<PdfDocumentMetadata> getCurrentBillingDocument(
    BillingRequest request,
  ) =>
      _client.getCurrentBillingDocument(request.policyNumber, request);
}
