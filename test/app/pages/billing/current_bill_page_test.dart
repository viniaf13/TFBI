// Mocks
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/current_bill/current_billing_doc_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/current_bill/current_bill_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../widgets/tfb_widget_tester.dart';
import '../../cubits/member_summary/billing_member_summary_consumer_test.dart';

class MockCurrentBillingDocCubit extends MockCubit<CurrentBillingDocState>
    implements CurrentBillingDocCubit {
  @override
  Future<void> fetchCurrentBillingDocument(PolicySummary policy) async {}
}

void main() {
  group('CurrentBillPage', () {
    testWidgets('renders correctly in initial state',
        (WidgetTester tester) async {
      final cubit = MockCurrentBillingDocCubit();
      when(() => cubit.state).thenReturn(CurrentBillingDocInitState());

      await tester.pumpWidget(
        TfbWidgetTester(
          mockCurrentBillDocCubit: cubit,
          child: BlocProvider.value(
            value: cubit,
            child: CurrentBillPage(
              params: CurrentBillPageParameters(policySummary: mockPolicy),
            ),
          ),
        ),
      );

      expect(find.byType(TfbPdfViewer), findsOneWidget);
      expect(find.text('Policy #policyNumber'), findsOneWidget);
    });

    testWidgets('renders loading state correctly', (tester) async {
      final cubit = MockCurrentBillingDocCubit();
      when(() => cubit.state).thenReturn(CurrentBillingDocProcessingState());

      await tester.pumpWidget(
        TfbWidgetTester(
          mockCurrentBillDocCubit: cubit,
          child: BlocProvider.value(
            value: cubit,
            child: CurrentBillPage(
              params: CurrentBillPageParameters(policySummary: mockPolicy),
            ),
          ),
        ),
      );

      expect(find.byType(TfbLoadingOverlay), findsOneWidget);
    });

    testWidgets('renders success state correctly', (tester) async {
      final cubit = MockCurrentBillingDocCubit();
      when(() => cubit.state).thenReturn(
        CurrentBillingDocSuccessState(filePath: 'test.pdf'),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          mockCurrentBillDocCubit: cubit,
          child: BlocProvider.value(
            value: cubit,
            child: CurrentBillPage(
              params: CurrentBillPageParameters(policySummary: mockPolicy),
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TfbPdfViewer &&
              widget.isSuccess == true &&
              widget.filePath == 'test.pdf',
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders error state correctly', (tester) async {
      final cubit = MockCurrentBillingDocCubit();
      when(() => cubit.state)
          .thenReturn(CurrentBillingDocFailureState(error: TfbRequestError()));

      await tester.pumpWidget(
        TfbWidgetTester(
          mockCurrentBillDocCubit: cubit,
          child: BlocProvider.value(
            value: cubit,
            child: ScaffoldMessenger(
              child: Scaffold(
                body: CurrentBillPage(
                  params: CurrentBillPageParameters(policySummary: mockPolicy),
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
