import 'package:hive/hive.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_local_database.dart';

/// Repository for storing the metadata associated with an auto policies'
/// insurance card.
///
/// This includes the ID of the insurance card, the path to the PDF file, the
/// vehicle titles associated with the insurance card, and the date the
/// card expires.
class TfbAutoPolicyDocumentMetadataRepository {
  TfbAutoPolicyDocumentMetadataRepository(this.database);

  factory TfbAutoPolicyDocumentMetadataRepository.withDefaultDatabase() {
    return TfbAutoPolicyDocumentMetadataRepository(
      LocalDatabase(_defaultDatabaseKey, hive: Hive),
    );
  }

  static const String _defaultDatabaseKey = 'AUTO_ID_METADATA_BOX';

  final LocalDatabase<String> database;

  /// Save the insurance card metadata to local storage
  ///
  /// Saves a json encoded [TfbAutoPolicyDocumentMetadata] object.
  Future<void> save(TfbAutoPolicyDocumentMetadata metadata) async {
    await database.put(metadata.id, metadata.toJson());
  }

  /// Get an insurance card metadata object from local storage using the
  /// documents ID
  Future<TfbAutoPolicyDocumentMetadata?> read(String id) async {
    try {
      final response = await database.get(id);

      if (response is String && response.isNotEmpty) {
        return TfbAutoPolicyDocumentMetadata.fromJson(response);
      }
    } catch (_) {}

    return null;
  }

  /// Delete an insurance card metadata object from local storage using the
  /// document's ID
  Future<void> delete(String id) async {
    await database.put(id, '');
  }

  /// Get all auto policy document metadata objects from local storage
  Future<List<TfbAutoPolicyDocumentMetadata?>> readAll() async {
    final response = await database.getAll();

    return List.from(
      (response as List<String>)
          .where((e) => e.isNotEmpty)
          .map(TfbAutoPolicyDocumentMetadata.fromJson),
    );
  }

  /// Clear all saved metadata objects from local storage
  Future<void> deleteAll() => database.deleteAll();
}
