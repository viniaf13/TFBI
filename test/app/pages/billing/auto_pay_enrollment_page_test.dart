import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/auto_pay_enrollment_page.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_tfb_policy_lookup_repository.dart';
import '../../../widgets/tfb_widget_tester.dart';
import '../policy_detail/widgets/insurance_card_content_test.dart';

class MockRoutingValidationCubit extends MockCubit<RoutingValidationState>
    implements RoutingValidationCubit {}

void main() {
  final policy = MockPolicySummary();
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUp(() {
    registerFallbackValue(RoutingValidationInitState());
    when(() => policy.policyNumber).thenReturn('123');
    when(() => policy.policyInsuredName).thenReturn('John Smith');
    when(() => policy.isAutoPayEnabled).thenReturn(false);
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  group('AutoPayEnrollmentPage', () {
    testWidgets('displays enroll title', (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );

      // 'Enroll in AutoPay' exists in the first child widget && the app bar
      expect(find.text('Enroll in AutoPay'), findsNWidgets(2));
    });

    testWidgets('displays manage title', (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);
      when(() => policy.isAutoPayEnabled).thenReturn(true);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );

      // 'Enroll in AutoPay' exists in the first child widget && the app bar
      expect(find.text('Manage AutoPay'), findsNWidgets(2));
    });

    testWidgets('shows submit button', (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );
      expect(find.byType(TfbFilledButton), findsOneWidget);
    });

    testWidgets('submit disabled initially', (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );

      final button = tester.widget<TfbFilledButton>(
        find.byType(TfbFilledButton),
      );

      expect(button.onPressed, isNull);
    });

    testWidgets('An incorrect routing number shows the format error message',
        (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );

      final found = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.type == ValidationType.bankRoutingNumber,
      );

      await tester.enterText(found, '123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('Please enter 9 characters'), findsOneWidget);
    });

    testWidgets('An incorrect name on bank account shows an error message',
        (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );

      final found = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.type == ValidationType.bankAccountName,
      );

      await tester.enterText(found, '123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text('Please enter between 4 and 60 characters'),
        findsOneWidget,
      );
    });

    testWidgets('An incorrect bank account number shows an error message',
        (tester) async {
      final repo = MockTfbPolicyLookupRepository();
      final cubit = RoutingValidationCubit(repository: repo);

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AutopayBloc(repository: repo),
          child: Provider<TfbPolicyLookupRepository>(
            create: (_) => repo,
            child: TfbWidgetTester(
              mockStatusBarScrollCubit: mockStatusBarScrollCubit,
              child: BlocProvider<RoutingValidationCubit>(
                create: (_) => cubit,
                child: AutoPayEnrollmentPage(policy: policy),
              ),
            ),
          ),
        ),
      );

      final found = find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.type == ValidationType.bankAccountNumber,
      );

      await tester.enterText(found.first, '123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.text('Please enter between 4 and 17 characters'),
        findsOneWidget,
      );
    });
  });

  testWidgets('Bank name at full opacity on success', (tester) async {
    final repo = MockTfbPolicyLookupRepository();
    final cubit = RoutingValidationCubit(repository: repo);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => AutopayBloc(repository: repo),
        child: Provider<TfbPolicyLookupRepository>(
          create: (_) => repo,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            mockRoutingValidationCubit: cubit,
            child: AutoPayEnrollmentPage(policy: policy),
          ),
        ),
      ),
    );

    cubit.emit(RoutingValidationSuccessState(response: 'Bank XYZ'));

    await tester.pump();
    final bankName = find.byWidgetPredicate(
      (widget) =>
          widget is ValidatingFormField &&
          widget.type == ValidationType.bankName,
    );

    final bankNameField = tester.widget<ValidatingFormField>(bankName);
    expect(find.text('Bank XYZ'), findsOneWidget);
    expect(bankNameField.controller?.text, 'Bank XYZ');
    expect(find.byType(Opacity), findsNWidgets(2));
    expect(tester.widget<Opacity>(find.byType(Opacity).first).opacity, 1.0);
  });

  testWidgets('Clear bank name and opacity at half on failure', (tester) async {
    final repo = MockTfbPolicyLookupRepository();
    final cubit = RoutingValidationCubit(repository: repo);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => AutopayBloc(repository: repo),
        child: Provider<TfbPolicyLookupRepository>(
          create: (_) => repo,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            mockRoutingValidationCubit: cubit,
            child: AutoPayEnrollmentPage(policy: policy),
          ),
        ),
      ),
    );

    cubit.emit(RoutingValidationFailureState(error: TfbRequestError()));

    await tester.pump();

    final bankName = find.byWidgetPredicate(
      (widget) =>
          widget is ValidatingFormField &&
          widget.type == ValidationType.bankName,
    );

    final bankNameField = tester.widget<ValidatingFormField>(bankName);

    expect(find.byType(Opacity), findsNWidgets(2));
    expect(
      tester.widget<Opacity>(find.byType(Opacity).first).opacity,
      0.5,
    );
    expect(bankNameField.controller?.text.isNullOrEmpty, isTrue);
  });

  testWidgets(
      'While the autopay request is processing, the page should show a loading overlay, and remove the loading overlay after processing is complete',
      (tester) async {
    final repo = MockTfbPolicyLookupRepository();
    final cubit = RoutingValidationCubit(repository: repo);
    final AutopayBloc autopayBloc = AutopayBloc(repository: repo);

    await tester.pumpWidget(
      BlocProvider.value(
        value: autopayBloc,
        child: Provider<TfbPolicyLookupRepository>(
          create: (_) => repo,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            mockRoutingValidationCubit: cubit,
            child: AutoPayEnrollmentPage(policy: policy),
          ),
        ),
      ),
    );

    autopayBloc.emit(AutopayProcessing());
    await tester.pump();
    expect(find.byType(TfbLoadingOverlay), findsOneWidget);

    autopayBloc.emit(AutopayInitial());
    await tester.pump();
    expect(find.byType(TfbLoadingOverlay), findsNothing);
  });
}
