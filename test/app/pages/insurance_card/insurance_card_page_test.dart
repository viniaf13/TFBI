import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/insurance_card_pdf_view_event.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/insurance_card/insurance_card_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';

import '../../../mocks/mock_auto_policy.dart';
import '../../../mocks/mock_policy_lookup_client.dart';
import '../../../mocks/mock_save_auto_id_card.dart';
import '../../../widgets/tfb_widget_tester.dart';
import '../../analytics/mock_analytics_provider.dart';

void main() {
  late MockAutoPolicyCubit autoPolicyCubit;
  late MockSaveAutoIdCardCubit saveAutoIdCardCubit;
  late MockAnalyticsProvider mockAnalyticsProvider;

  final mockPolicy = MockPolicy.createPolicySummary();
  final TfbAutoPolicyDocumentMetadata documentMetadata =
      TfbAutoPolicyDocumentMetadata(
    vehicleDisplayTitles: ['vehicleDisplayTitles'],
    expirationDate: DateTime.now(),
    documentPath: 'documentPath',
    id: '1',
    policyNumber: mockPolicy.policyNumber,
  );

  setUpAll(() {
    autoPolicyCubit = MockAutoPolicyCubit();
    saveAutoIdCardCubit = MockSaveAutoIdCardCubit();
    registerFallbackValue(FakeAutoPolicyState());
    registerFallbackValue(FakeSaveAutoIdCardState());

    mockAnalyticsProvider = MockAnalyticsProvider();
    TfbAnalytics.instance.add(mockAnalyticsProvider);
    TfbAnalytics.instance.init(const TfbAnalyticsConfig());
  });

  group('InsuranceCardPage Widget Tests', () {
    testWidgets('AutoPolicySuccess and SaveAutoIdCardSuccess',
        (WidgetTester tester) async {
      final mockAutoDetail = MockPolicy.createAutoPolicyDetail(
        policyNum: mockPolicy.policyNumber,
      );

      when(() => autoPolicyCubit.state).thenReturn(
        AutoPolicySuccess(
          autoPolicyDetail: mockAutoDetail,
        ),
      );
      when(() => saveAutoIdCardCubit.state).thenReturn(
        SaveAutoIdCardSuccess(
          idCardMetadata: documentMetadata,
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AutoPolicyCubit>(
                create: (context) => autoPolicyCubit,
              ),
              BlocProvider<SaveAutoIdCardCubit>(
                create: (context) => saveAutoIdCardCubit,
              ),
            ],
            child: InsuranceCardPage(
              params: InsuranceCardPageParameters(
                policySummary: mockPolicy,
                pdfViewerEventsParameters: PdfViewerEventsParameters(),
              ),
            ),
          ),
        ),
      );

      final pdfViewerFinder = find.byType(TfbPdfViewer);
      expect(
        tester.widget(pdfViewerFinder),
        isA<TfbPdfViewer>()
            .having(
              (p0) => p0.filePath,
              'filePath',
              documentMetadata.documentPath,
            )
            .having((p0) => p0.isLoading, 'isLoading', false)
            .having((p0) => p0.isError, 'isError', false)
            .having((p0) => p0.isSuccess, 'isSucess', true),
      );

      final event = mockAnalyticsProvider.loggedEvents
          .whereType<InsuranceCardPdfViewEvent>()
          .first;

      expect(event.name, kInsuranceCardPdfViewEvent);
    });
  });
}
