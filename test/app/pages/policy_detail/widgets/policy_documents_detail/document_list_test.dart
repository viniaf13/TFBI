import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/document_list.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/text_with_pdf.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/mock_tfb_navigator.dart';
import '../../../../../mocks/page_parameters/mock_policy_document_page_parameters.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late List<PolicyListMetadata> mockDocuments;

  final policyDocumentPageParameters =
      MockPolicyDocumentPageParameters.getParams();
  final mockNavigator = MockTfbNavigator();

  setUpAll(() {
    registerFallbackValue(policyDocumentPageParameters);
  });

  setUp(
    () {
      mockDocuments = [
        PolicyListMetadata(
          date: 'February 17, 2023',
          documentId: '123',
          formDescription: '',
          labelDescription: 'Cover Letter - Complaint',
          pageNumber: 0,
          versionId: '',
        ),
        PolicyListMetadata(
          date: 'February 17, 2022',
          documentId: '123',
          formDescription: '',
          labelDescription: 'Joint Notice',
          pageNumber: 0,
          versionId: '',
        ),
      ];
    },
  );

  testWidgets(
    'DocumentList widget should be rendered with correct title and documents',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: DocumentList(
              title: 'Issued: ${mockDocuments[0].date}',
              policySummary: MockPolicy.createPolicySummary(),
              documents: mockDocuments,
            ),
          ),
        ),
      );

      final foundDocumentsList = find.byType(DocumentList);

      final documentListWidget = find.text('Issued: ${mockDocuments[0].date}');
      final pdfDocumentWidgets = find.byType(TextWithPdf);

      expect(foundDocumentsList, findsOneWidget);
      expect(pdfDocumentWidgets, findsWidgets);
      expect(documentListWidget, findsOneWidget);
    },
  );

  testWidgets(
    'onTap should call pushPolicyDocumentPdfPage',
    (WidgetTester tester) async {
      when(
        () => mockNavigator.pushPolicyDocumentPdfPage(any()),
      ).thenAnswer((_) => Future<Object?>.value());

      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockNavigator,
          child: Scaffold(
            body: DocumentList(
              title: 'Issued: ${mockDocuments[0].date}',
              policySummary: MockPolicy.createPolicySummary(),
              documents: mockDocuments,
            ),
          ),
        ),
      );

      final textWithPdfWidget = find.byType(TextWithPdf).first;
      await tester.tap(textWithPdfWidget);
      await tester.pumpAndSettle();
      verify(
        () => mockNavigator.pushPolicyDocumentPdfPage(any()),
      ).called(1);
    },
  );
}
