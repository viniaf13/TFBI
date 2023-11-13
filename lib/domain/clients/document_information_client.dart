// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_document_version_request.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_request.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_document_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_documents_request.dart';

part 'document_information_client.g.dart';

const kGetAutoIdCardEndpoint =
    '/services/TFBIC.Services.RESTTCI.Search/tci/getautoidcard/{policyNumber}/{policyType}/{expirationDate}';
const kGetSixMonthAutoPolicyEndpoint =
    '/services/TFBIC.Services.RESTPA6.Lookup/policyholder/{policyNumber}';
const kPostBillingDocumentListEndpoint =
    '/services/TFBIC.Services.RESTTCI.Search/document/list/{policyNumber}';
const kPostPolicyDocumentEndpoint =
    '/services/TFBIC.Services.RESTTCI.Search/document/policy/byid/{policyNumber}';
const kPostPolicyDocumentListEndpoint =
    '/services/TFBIC.Services.RESTTCI.Search/document/policy/list/{policyNumber}';
const kGetPolicyStaticDocumentsEndpoint =
    '/services/TFBIC.Services.RESTTCI.Search/document/policy/static';
const kPostBillingDocumentByVersion =
    '/services/TFBIC.Services.RESTTCI.Search/document/byversion/{policyNumber}';
const kPostCurrentBillingDocumentEndPoint =
    '/services/TFBIC.Services.RESTTCI.Search/document/current/{policyNumber}';

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class TfbDocumentInformationClient extends TfbClient {
  factory TfbDocumentInformationClient({
    required String baseUrl,
    required Dio dio,
  }) =>
      _TfbDocumentInformationClient(
        dio,
        baseUrl: baseUrl,
      );

  @GET(kGetAutoIdCardEndpoint)
  Future<PdfDocumentMetadata> getAutoIdCardWithTypeAndDate(
    @Path('policyNumber') String policyNumber,
    @Path('policyType') String policyType,
    @Path('expirationDate') String expirationDate,
  );

  @GET(kGetSixMonthAutoPolicyEndpoint)
  Future<AutoPolicyDetail> getPersonalSixMonthAutoPolicyAbbreviated(
    @Path('policyNumber') String policyNumber,
  );

  @POST(kPostCurrentBillingDocumentEndPoint)
  Future<PdfDocumentMetadata> getCurrentBillingDocument(
    @Path('policyNumber') String policyNumber,
    @Body() BillingRequest request,
  );

  @POST(kPostBillingDocumentListEndpoint)
  Future<List<BillingListMetadata>> getBillingDocuments(
    @Path('policyNumber') String policyNumber,
    @Body() BillingRequest request,
  );

  @POST(kPostPolicyDocumentEndpoint)
  Future<PdfDocumentMetadata> getPolicyDocumentMetadata(
    @Path('policyNumber') String policyNumber,
    @Body() PolicyDocumentRequest request,
  );

  @POST(kPostPolicyDocumentListEndpoint)
  Future<List<PolicyListMetadata>> getPolicyDocuments(
    @Path('policyNumber') String policyNumber,
    @Body() PolicyListRequest request,
  );

  @POST(kGetPolicyStaticDocumentsEndpoint)
  Future<List<PolicyStaticDocument>> getPolicyStaticDocuments(
    @Body() PolicyStaticDocumentsRequest request,
  );

  @POST(kPostBillingDocumentByVersion)
  Future<PdfDocumentMetadata> getBillingDocumentByVersion(
    @Path('policyNumber') String policyNumber,
    @Body() BillingDocumentVersionRequest request,
  );
}
