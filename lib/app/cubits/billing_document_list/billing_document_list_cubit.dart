import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_request.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

class BillingDocumentListCubit
    extends TfbSingleRequestCubit<List<BillingListMetadata>> {
  static Future<List<BillingListMetadata>> createRequest(
    TfbDocumentInformationClient client,
    PolicySummary summary,
  ) =>
      client.getBillingDocuments(
        summary.policyNumber,
        BillingRequest.fromPolicySummary(summary),
      );
}
