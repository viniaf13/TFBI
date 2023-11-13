import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/policy_static_documents.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_static_document.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';

import '../../../../../mocks/mock_environment_notifier.dart';
import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/mock_tfb_navigator.dart';
import '../../../../../mocks/models/mock_policy_static_document.dart';
import '../../../../../mocks/page_parameters/mock_policy_document_page_parameters.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockEnvironmentNotifier mockEnvironmentNotifier;
  final PolicyDocumentPageParameters policyDocumentPageParameters =
      MockPolicyDocumentPageParameters.getParams();
  late MockTfbNavigator mockNavigator;
  late PolicySummary mockPolicySummary;
  late PolicyStaticDocument mockStaticDocument;

  setUpAll(() {
    registerFallbackValue(policyDocumentPageParameters);
  });

  setUp(() {
    mockEnvironmentNotifier = MockEnvironmentNotifier();
    mockPolicySummary = MockPolicy.createPolicySummary();
    mockStaticDocument = MockPolicyStaticDocument.getStaticDocument();
    mockNavigator = MockTfbNavigator();

    when(() => mockEnvironmentNotifier.environment).thenReturn(
      TfbEnvironmentDev(),
    );
  });

  testWidgets('onTap navigates to PolicyDocumentPage',
      (WidgetTester tester) async {
    when(
      () => mockNavigator.pushPolicyDocumentPdfPage(any()),
    ).thenAnswer((_) => Future<Object?>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: PolicyStaticDocuments(
              policySummary: mockPolicySummary,
              policyStaticDocuments: [mockStaticDocument],
            ),
          ),
        ),
      ),
    );

    final pdfButton = find.text(mockStaticDocument.documentTitle);
    await tester.ensureVisible(pdfButton);

    await tester.pump();
    await tester.tap(pdfButton);

    verify(
      () => mockNavigator.pushPolicyDocumentPdfPage(any()),
    ).called(1);
  });

  testWidgets(
      'should display noStaticDocuments when policyStaticDocuments is empty',
      (WidgetTester tester) async {
    when(
      () => mockNavigator.pushPolicyDocumentPdfPage(any()),
    ).thenAnswer((_) => Future<Object?>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockNavigator,
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: PolicyStaticDocuments(
              policySummary: mockPolicySummary,
              policyStaticDocuments: const [],
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().noStaticDocuments),
      findsOneWidget,
    );
  });
}
