import 'package:txfb_insurance_flutter/app/pages/login/widgets/vehicle_card.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_flat_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class CachedContent extends StatelessWidget {
  const CachedContent({required this.policies, super.key});

  final List<TfbAutoPolicyDocumentMetadata?> policies;

  @override
  Widget build(BuildContext context) {
    final vehicles =
        TfbFlatAutoPolicyDocumentMetadata.fromAutoPolicyDocumentMetadataList(
      policies,
    );

    return Container(
      margin: const EdgeInsets.only(top: kSpacingMedium),
      padding: const EdgeInsets.all(kSpacingMedium),
      decoration: BoxDecoration(
        color: TfbBrandColors.white,
        borderRadius: context.radii.defaultRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSpacingMedium),
            child: Text(
              context.getLocalizationOf.loginOfflineInsuranceCardTitle,
              style: context.tfbText.header3.copyWith(
                color: TfbBrandColors.blueHighest,
              ),
            ),
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: vehicles.length,
            itemBuilder: (_, index) =>
                VehicleCard(policyDocumentMetadata: vehicles.elementAt(index)),
            separatorBuilder: (context, index) => const SizedBox(
              height: kSpacingSmall,
            ),
          ),
        ],
      ),
    );
  }
}
