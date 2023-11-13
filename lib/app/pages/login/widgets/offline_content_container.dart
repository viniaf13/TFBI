import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/no_cached_content.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/offline_cached_content.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class OfflineContentContainer extends StatelessWidget {
  const OfflineContentContainer({
    required this.autoPolicyDocumentMetadataRepository,
    super.key,
  });

  final TfbAutoPolicyDocumentMetadataRepository
      autoPolicyDocumentMetadataRepository;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom +
            MediaQuery.paddingOf(context).bottom +
            kSpacingMedium,
      ),
      child: FutureBuilder(
        future: autoPolicyDocumentMetadataRepository.readAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
            return const NoCachedContent();
          }

          return CachedContent(
            policies: snapshot.data ?? [],
          );
        },
      ),
    );
  }
}
