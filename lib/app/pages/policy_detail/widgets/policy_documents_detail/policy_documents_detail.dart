import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/document_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/policy_static_documents.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/expandable_card/expandable_card.dart';

class PolicyDocumentsDetail extends StatelessWidget {
  const PolicyDocumentsDetail({
    required this.policy,
    required this.policyDocuments,
    required this.policyStaticDocuments,
    super.key,
  });

  final PolicySummary policy;
  final List<PolicyListMetadata> policyDocuments;
  final List<PolicyStaticDocument> policyStaticDocuments;

  @override
  Widget build(BuildContext context) {
    final documents = policyDocuments.groupBy((data) => data.date);

    return ExpandableCard(
      headerContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingMedium),
            child: Text(
              context.getLocalizationOf.policyDocumentsCardTitle,
              style: context.tfbText.header3
                  .copyWith(color: TfbBrandColors.blueHighest),
            ),
          ),
          PolicyStaticDocuments(
            policySummary: policy,
            policyStaticDocuments: policyStaticDocuments,
          ),
        ],
      ),
      headerCrossAxisAlignment: CrossAxisAlignment.start,
      expandableSectionLabel: Text(
        context.getLocalizationOf.otherDocumentsLabel,
        style: context.tfbText.bodyMediumSmall
            .copyWith(color: TfbBrandColors.blueHighest),
      ),
      expandableSectionContent: documents.isEmpty
          ? null
          : documents.entries
              .map(
                (documentList) => Padding(
                  padding: const EdgeInsets.only(bottom: kSpacingMedium),
                  child: DocumentList(
                    title:
                        '${context.getLocalizationOf.issuedLabel}: ${documentList.key}',
                    policySummary: policy,
                    documents: documentList.value,
                  ),
                ),
              )
              .toList(),
    );
  }
}
