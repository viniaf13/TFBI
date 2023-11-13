import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/document_events.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/insurance_card_event.dart';
import 'package:txfb_insurance_flutter/app/analytics/tfb_analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_flat_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/light_colors.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({required this.policyDocumentMetadata, super.key});

  final TfbFlatAutoPolicyDocumentMetadata policyDocumentMetadata;

  @override
  Widget build(BuildContext context) {
    return TfbFilledButton(
      onPressed: () {
        TfbAnalytics.instance.track(
          ViewIdCardEvent(context.screenName),
        );
        context.navigator.goPdfViewerPage(
          PdfViewerPageParameters(
            title: context.getLocalizationOf.insuranceCardPdfViewerPageTitle(
              policyDocumentMetadata.policyNumber,
            ),
            filePath: policyDocumentMetadata.documentPath,
            pdfViewerEventsParameters: PdfViewerEventsParameters(
              screenName: context.screenName,
              cta: DocumentEventViewOptions.viewIDCard.value,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: kSpacingMediumSmall,
        ),
        decoration: BoxDecoration(
          borderRadius: context.radii.defaultRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: kSpacingMedium),
                child: Text(
                  policyDocumentMetadata.vehicleName.toTitleCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHighest,
                  ),
                ),
              ),
            ),
            ImageIcon(
              AssetImage(TfbAssetStrings.basicArrowRight),
              color: LightColors.lightBlueIcon,
            ),
          ],
        ),
      ),
    );
  }
}
