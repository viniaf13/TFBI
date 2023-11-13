import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_paperless_lookup_consumer.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/paperless_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

import '../../../widgets/tfb_widget_tester.dart';

class MockPolicySummary extends Mock implements PolicySummary {}

class MockPaperlessLookupCubit extends MockCubit<PaperlessLookupState>
    implements PaperlessLookupCubit {}

void main() {
  group('BillingEbillLookupConsumer', () {
    final PolicySummary policy = MockPolicySummary();

    testWidgets('lookup success displays phone number', (tester) async {
      final cubit = MockPaperlessLookupCubit();
      when(() => cubit.state).thenReturn(
        PaperlessLookupSuccessState(
          response: PaperlessLookupResponse(
            memberEmailAddress: 'fake@email.com',
          ),
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<PaperlessLookupCubit>(
            create: (_) => cubit,
            child: BillingPaperlessLookupConsumer(policy: policy),
          ),
        ),
      );

      expect(find.text('Send to: fake@email.com'), findsOneWidget);
    });

    testWidgets('lookup failure displays error', (tester) async {
      final cubit = MockPaperlessLookupCubit();
      when(() => cubit.state).thenReturn(
        PaperlessLookupFailureState(
          error: TfbRequestError(
            message: 'error',
          ),
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<PaperlessLookupCubit>(
            create: (_) => cubit,
            child: BillingPaperlessLookupConsumer(policy: policy),
          ),
        ),
      );

      expect(find.text('Error loading email address.'), findsOneWidget);
    });
  });
}
