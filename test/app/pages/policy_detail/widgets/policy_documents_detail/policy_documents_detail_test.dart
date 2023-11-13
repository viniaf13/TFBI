import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document/auto_policy_document_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/policy_documents_builder.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/text_with_pdf.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_auto_policy_document_cubit.dart';
import '../../../../../mocks/mock_environment_notifier.dart';
import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/page_parameters/mock_pdf_viewer_events_parameters.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockAutoPolicyDocumentCubit autoPolicyDocumentCubit;
  late List<PolicyListMetadata> policyList;
  late List<PolicyStaticDocument> policyStaticDocument;
  final PolicySummary mockPolicySummary = MockPolicy.createPolicySummary();
  final MockEnvironmentNotifier mockEnvironmentNotifier =
      MockEnvironmentNotifier();

  setUpAll(() {
    policyList = [
      PolicyListMetadata(
        date: 'February 17, 2023',
        documentId: '123',
        formDescription: '',
        labelDescription: 'Cover Letter - Complaint',
        pageNumber: 0,
        versionId: '',
      ),
      PolicyListMetadata(
        date: 'July 17, 2022',
        documentId: '123',
        formDescription: '',
        labelDescription: 'Joint Notice',
        pageNumber: 0,
        versionId: '',
      ),
    ];
    policyStaticDocument = [
      PolicyStaticDocument(
        documentId: 4,
        documentTitle: 'documentTitle',
        documentType: 'documentType',
        documentUrl: 'documentUrl',
      ),
    ];

    registerFallbackValue(FakeAutoPolicyDocumentState());
    registerFallbackValue(FakeAutoPolicyDocumentState());

    final pdfViewerEventsParameters =
        MockPdfViewerEventsParameters.getEventsParameters();
    registerFallbackValue(
      pdfViewerEventsParameters,
    );
  });

  setUp(() {
    autoPolicyDocumentCubit = MockAutoPolicyDocumentCubit();

    when(
      () => autoPolicyDocumentCubit.getPolicyDocumentList(mockPolicySummary),
    ).thenAnswer((_) => Future.value());
    when(() => mockEnvironmentNotifier.environment).thenReturn(
      TfbEnvironmentDev(),
    );
  });

  testWidgets(
    'Policy documents detail should be rendered with header, pdf and minimized expandable section.',
    (WidgetTester tester) async {
      when(() => autoPolicyDocumentCubit.state).thenReturn(
        AutoPolicyDocumentSuccess(
          policyDocuments: policyList,
          policyStaticDocuments: policyStaticDocument,
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: ChangeNotifierProvider<EnvironmentNotifier>(
              create: (context) => mockEnvironmentNotifier,
              child: BlocProvider<AutoPolicyDocumentCubit>.value(
                value: autoPolicyDocumentCubit,
                child: PolicyDocumentsBuilder(policy: mockPolicySummary),
              ),
            ),
          ),
        ),
      );

      final headerWidget = find.text('Policy Documents');
      final pdfWidget = find.byType(TextWithPdf);
      final expandableSection = find.text('Other documents');

      expect(headerWidget, findsOneWidget);
      expect(pdfWidget, findsOneWidget);
      expect(expandableSection, findsOneWidget);
    },
  );

  testWidgets(
    'Policy documents detail should be rendered with header and pdf, without expandable section',
    (WidgetTester tester) async {
      mocktail.when(() => autoPolicyDocumentCubit.state).thenReturn(
            AutoPolicyDocumentError(error: TfbRequestError()),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: Scaffold(
              body: BlocProvider<AutoPolicyDocumentCubit>.value(
                value: autoPolicyDocumentCubit,
                child: PolicyDocumentsBuilder(policy: mockPolicySummary),
              ),
            ),
          ),
        ),
      );

      final headerWidget = find.text('Policy Documents');
      final pdfWidget = find.text('Error loading documents');
      final expandableSection = find.text('Other documents');

      expect(headerWidget, findsOneWidget);
      expect(pdfWidget, findsOneWidget);
      expect(expandableSection, findsNothing);
    },
  );

  testWidgets(
    'Policy documents detail should be rendered with PDF Documents when the Others documents was clicked',
    (WidgetTester tester) async {
      mocktail.when(() => autoPolicyDocumentCubit.state).thenReturn(
            AutoPolicyDocumentSuccess(
              policyDocuments: policyList,
              policyStaticDocuments: policyStaticDocument,
            ),
          );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: Scaffold(
              body: BlocProvider<AutoPolicyDocumentCubit>.value(
                value: autoPolicyDocumentCubit,
                child: PolicyDocumentsBuilder(policy: mockPolicySummary),
              ),
            ),
          ),
        ),
      );

      final headerWidget = find.text('Policy Documents');
      final pdfWidget = find.byType(TextWithPdf);
      final expandableSection = find.text('Other documents');

      expect(headerWidget, findsOneWidget);
      expect(pdfWidget, findsOneWidget);
      expect(expandableSection, findsOneWidget);

      await tester.tap(expandableSection);
      await tester.pumpAndSettle();

      final documentListWidget = find.text('Issued: ${policyList[0].date}');
      final pdfDocumentWidgets = find.byType(TextWithPdf);

      expect(pdfDocumentWidgets, findsWidgets);
      expect(documentListWidget, findsOneWidget);
    },
  );
}
