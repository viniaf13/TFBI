import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';

class TfbFlatAutoPolicyDocumentMetadata {
  TfbFlatAutoPolicyDocumentMetadata({
    required this.vehicleName,
    required this.documentPath,
    required this.expirationDate,
    required this.id,
    required this.policyNumber,
  });

  static List<TfbFlatAutoPolicyDocumentMetadata>
      fromAutoPolicyDocumentMetadataList(
    List<TfbAutoPolicyDocumentMetadata?> policies,
  ) {
    return flatten(
      policies
          .where(
            (element) => element != null,
          )
          .map(
            (policy) => policy!.vehicleDisplayTitles.map(
              (title) => TfbFlatAutoPolicyDocumentMetadata(
                vehicleName: title,
                documentPath: policy.documentPath,
                expirationDate: policy.expirationDate,
                id: policy.id,
                policyNumber: policy.policyNumber,
              ),
            ),
          ),
    );
  }

  String vehicleName;
  String documentPath;
  DateTime expirationDate;
  String id;
  String policyNumber;
}

List<T> flatten<T>(Iterable<Iterable<T>> list) =>
    [for (final sublist in list) ...sublist];
