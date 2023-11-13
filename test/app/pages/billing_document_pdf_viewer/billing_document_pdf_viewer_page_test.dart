import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_pdf/billing_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_document_pdf_viewer/billing_document_pdf_viewer_page.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../widgets/tfb_widget_tester.dart';
import '../../cubits/auto_policy/auto_policy_cubit_test.dart';

class MockBillingDocumentPdfCubit extends MockCubit<BillingDocumentPdfState>
    implements BillingDocumentPdfCubit {}

void main() {
  setUp(() {
    registerFallbackValue(testPolicySummary);
    registerFallbackValue(_testBillingMetadata);
  });

  testWidgets(
      'When the billing document pdf cubit is in a processing state, show the loading indicator',
      (tester) async {
    final BillingDocumentPdfCubit mockCubit = MockBillingDocumentPdfCubit();

    when(() => mockCubit.state).thenReturn(BillingDocumentPdfProcessing());

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: mockCubit,
          child: BillingDocumentPdfViewerPage(
            params: BillingDocumentPdfViewerPageParameters(
              metadata: _testBillingMetadata,
              policySummary: testPolicySummary,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(TfbLoadingOverlay), findsOneWidget);
  });

  testWidgets(
      'When the billing document pdf cubit is in the initial state, show the loading indicator',
      (tester) async {
    final BillingDocumentPdfCubit mockCubit = MockBillingDocumentPdfCubit();

    when(() => mockCubit.state).thenReturn(BillingDocumentPdfInitial());
    when(() => mockCubit.getBillingDocument(any(), any()))
        .thenAnswer((invocation) async {});

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: mockCubit,
          child: BillingDocumentPdfViewerPage(
            params: BillingDocumentPdfViewerPageParameters(
              metadata: BillingListMetadata(
                date: '',
                documentId: 'documentId',
                formDescription: 'formDescription',
                labelDescription: 'labelDescription',
                pageNumber: 1,
                versionId: 'versionId',
              ),
              policySummary: testPolicySummary,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(TfbLoadingOverlay), findsOneWidget);
  });

  testWidgets(
      'When the billing document pdf cubit is in a failed state, show the error snackbar',
      (tester) async {
    final BillingDocumentPdfCubit mockCubit = MockBillingDocumentPdfCubit();

    when(() => mockCubit.state)
        .thenReturn(BillingDocumentPdfError(TfbRequestError(message: 'ERROR')));

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: mockCubit,
          child: BillingDocumentPdfViewerPage(
            params: BillingDocumentPdfViewerPageParameters(
              metadata: BillingListMetadata(
                date: '',
                documentId: 'documentId',
                formDescription: 'formDescription',
                labelDescription: 'labelDescription',
                pageNumber: 1,
                versionId: 'versionId',
              ),
              policySummary: testPolicySummary,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TfbLoadingOverlay), findsNothing);
    expect(
      find.text(AppLocalizationsEn().somethingWentWrong),
      findsOneWidget,
    );
  });
}

final _testBillingMetadata = BillingListMetadata(
  date: '',
  documentId: 'documentId',
  formDescription: 'formDescription',
  labelDescription: 'labelDescription',
  pageNumber: 1,
  versionId: 'versionId',
);
