import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';

import '../mocks/mock_tfb_auto_policy_document_metadata_repository.dart';

/// Provides a policy document metadata repository onto the widget tree that
/// always returns an empty list for any read calls.
///
/// Needed for any test that displays the [LoginPage] widget to prevent it from
/// throwing a render error.
///
/// This class name is a mouthful!
class EmptyMockTfbAutoPolicyDocumentMetadataRepositoryProvider
    extends StatelessWidget {
  const EmptyMockTfbAutoPolicyDocumentMetadataRepositoryProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TfbAutoPolicyDocumentMetadataRepository documentMetadataRepository =
        MockTfbAutoPolicyDocumentMetadataRepository();
    when(documentMetadataRepository.readAll)
        .thenAnswer((invocation) => Future.value([]));

    return Provider.value(
      value: documentMetadataRepository,
      child: child,
    );
  }
}
