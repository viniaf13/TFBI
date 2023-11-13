// Mocks
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document_pdf/auto_policy_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/current_bill/current_billing_doc_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/pdf_document/pdf_document_page.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../mocks/mock_auto_policy_document_pdf_cubit.dart';
import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../widgets/tfb_widget_tester.dart';

class MockCurrentBillingDocCubit extends MockCubit<CurrentBillingDocState>
    implements CurrentBillingDocCubit {
  @override
  Future<void> fetchCurrentBillingDocument(PolicySummary policy) async {}
}

void main() {
  late AutoPolicyDocumentPdfCubit autoPolicyDocumentPdfCubit;

  final policySummary = MockPolicy.createPolicySummary();
  final testPolicyListMetadata = PolicyListMetadata(
    date: '20-07-2018',
    documentId: '123',
    formDescription: '2',
    labelDescription: 'document',
    pageNumber: 0,
    versionId: '1',
  );

  group('PolicyDocumentPage', () {
    setUp(() {
      autoPolicyDocumentPdfCubit = MockAutoPolicyDocumentPdfCubit();

      when(
        () => autoPolicyDocumentPdfCubit.getPolicyDocumentMetadata(
          policySummary,
          testPolicyListMetadata,
        ),
      ).thenAnswer((invocation) => Future.value());
    });

    testWidgets('renders correctly in initial state',
        (WidgetTester tester) async {
      when(() => autoPolicyDocumentPdfCubit.state)
          .thenReturn(AutoPolicyDocumentPdfInitial());

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<AutoPolicyDocumentPdfCubit>.value(
              value: autoPolicyDocumentPdfCubit,
              child: PolicyDocumentPage(
                params: PolicyDocumentPageParameters(
                  policySummary: policySummary,
                  documentMetadata: testPolicyListMetadata,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TfbPdfViewer), findsOneWidget);
      expect(
        find.text('Policy #${policySummary.policyNumber}'),
        findsOneWidget,
      );
    });

    testWidgets('renders loading state correctly', (tester) async {
      when(() => autoPolicyDocumentPdfCubit.state)
          .thenReturn(AutoPolicyDocumentPdfProcessing());

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<AutoPolicyDocumentPdfCubit>.value(
              value: autoPolicyDocumentPdfCubit,
              child: PolicyDocumentPage(
                params: PolicyDocumentPageParameters(
                  policySummary: policySummary,
                  documentMetadata: testPolicyListMetadata,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TfbLoadingOverlay), findsOneWidget);
    });

    testWidgets('renders success state correctly', (tester) async {
      when(() => autoPolicyDocumentPdfCubit.state).thenReturn(
        AutoPolicyDocumentPdfSuccess(
          documentMetadata: PdfDocumentMetadata(
            mimeType: '',
            pages: [PdfDocumentPage(content: '')],
            rotation: 0,
            scale: 1,
            supportedMimeTypes: ['pdf'],
            width: 0,
          ),
          filePath: 'file-path.pdf',
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<AutoPolicyDocumentPdfCubit>.value(
              value: autoPolicyDocumentPdfCubit,
              child: PolicyDocumentPage(
                params: PolicyDocumentPageParameters(
                  policySummary: policySummary,
                  documentMetadata: testPolicyListMetadata,
                ),
              ),
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TfbPdfViewer &&
              widget.isSuccess == true &&
              widget.filePath == 'file-path.pdf',
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders error state correctly', (tester) async {
      when(() => autoPolicyDocumentPdfCubit.state).thenReturn(
        AutoPolicyDocumentPdfError(
          error: TfbRequestError(),
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: BlocProvider<AutoPolicyDocumentPdfCubit>.value(
              value: autoPolicyDocumentPdfCubit,
              child: PolicyDocumentPage(
                params: PolicyDocumentPageParameters(
                  policySummary: policySummary,
                  documentMetadata: testPolicyListMetadata,
                ),
              ),
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is TfbPdfViewer && widget.isError == true,
        ),
        findsOneWidget,
      );
    });
  });
}
