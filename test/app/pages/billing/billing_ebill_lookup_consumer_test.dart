import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/ebill_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/paperless_billing/billing_ebill_lookup_consumer.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/paperless/ebill_lookup_response.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';

import '../../../widgets/tfb_widget_tester.dart';

class MockPolicySummary extends Mock implements PolicySummary {}

class MockEbillLookupCubit extends MockCubit<EbillLookUpState>
    implements EbillLookupCubit {}

void main() {
  group('BillingEbillLookupConsumer', () {
    final PolicySummary policy = MockPolicySummary();

    testWidgets('lookup success displays phone number', (tester) async {
      final cubit = MockEbillLookupCubit();
      when(() => cubit.state).thenReturn(
        EbillLookUpSuccessState(
          response: EbillLookupResponse(
            memberPhoneNumber: '1112223333',
          ),
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<EbillLookupCubit>(
            create: (_) => cubit,
            child: BillingEbillLookupConsumer(policy: policy),
          ),
        ),
      );

      expect(find.text('Send to: 111.222.3333'), findsOneWidget);
    });

    testWidgets('lookup failure displays error', (tester) async {
      final cubit = MockEbillLookupCubit();
      when(() => cubit.state).thenReturn(
        EbillLookUpFailureState(
          error: TfbRequestError(
            message: 'error',
          ),
        ),
      );
      when(() => policy.policyNumber).thenReturn('1234');

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<EbillLookupCubit>(
            create: (_) => cubit,
            child: BillingEbillLookupConsumer(policy: policy),
          ),
        ),
      );

      expect(find.text('Error loading phone number.'), findsOneWidget);
    });
  });
}
