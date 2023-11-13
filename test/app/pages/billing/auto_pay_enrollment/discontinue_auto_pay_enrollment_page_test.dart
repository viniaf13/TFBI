import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/discontinue_auto_pay_enrollment_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/widgets/cancel_app_bar_action.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';

import '../../../../domain/repositories/tfb_file_claim_repo_test.dart';
import '../../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../../mocks/mock_tfb_navigator.dart';
import '../../../../widgets/tfb_widget_tester.dart';
import '../../policy_detail/widgets/insurance_card_content_test.dart';

class MockPolicySummary extends Mock implements PolicySummary {}

class FakeInvocation extends Fake implements Invocation {}

void main() {
  group('DiscontinueAutoPayEnrollmentPage', () {
    late PolicySummary mockPolicy;
    late MockTfbPolicyLookupRepository repo;
    final MockStatusBarScrollCubit mockStatusBarScrollCubit =
        MockStatusBarScrollCubit();

    late TfbNavigator mockTfbNavigator;
    setUp(() {
      mockTfbNavigator = MockTfbNavigator();
      mockPolicy = MockPolicySummary();
      repo = MockTfbPolicyLookupRepository();
      when(() => mockStatusBarScrollCubit.state)
          .thenReturn(const StatusBarScrollInitial(''));
      registerFallbackValue(MockBuildContext());
    });

    setUpAll(
      () => registerFallbackValue(FakeInvocation()),
    );

    testWidgets('DiscontinueAutoPayEnrollmentPage renders correctly',
        (tester) async {
      when(() => mockPolicy.policyNumber).thenReturn('1234');
      when(() => mockPolicy.isAutoPayEnabled).thenReturn(true);

      await tester.pumpWidget(
        TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          mockNavigator: mockTfbNavigator,
          child: BlocProvider<AutopayBloc>(
            create: (context) => AutopayBloc(repository: repo),
            child: DiscontinueAutoPayEnrollmentPage(policy: mockPolicy),
          ),
        ),
      );

      expect(
        find.text(AppLocalizationsEn().autopayEnrollDiscontinueTitle),
        findsNWidgets(2),
      );
    });

    testWidgets('Correct text is displayed', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          mockNavigator: mockTfbNavigator,
          child: BlocProvider<AutopayBloc>(
            create: (context) => AutopayBloc(repository: repo),
            child: DiscontinueAutoPayEnrollmentPage(policy: mockPolicy),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(AppLocalizationsEn().autopayEnrollDiscontinueSubTitle),
        findsWidgets,
      );
      // Contains escaped trademark characters
      expect(
        find.textContaining('I am authorizing Texas Farm Bureau Insurance'),
        findsOneWidget,
      );
    });

    testWidgets('Discontinue button is initially disabled', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          mockNavigator: mockTfbNavigator,
          child: BlocProvider<AutopayBloc>(
            create: (context) => AutopayBloc(repository: repo),
            child: DiscontinueAutoPayEnrollmentPage(policy: mockPolicy),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(
        find.widgetWithText(
          TfbFilledButton,
          AppLocalizationsEn().discontinueAndDelete,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is TfbFilledButton && w.enabled == false,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Discontinue button enables when terms are checked',
        (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          mockNavigator: mockTfbNavigator,
          child: BlocProvider<AutopayBloc>(
            create: (context) => AutopayBloc(repository: repo),
            child: DiscontinueAutoPayEnrollmentPage(policy: mockPolicy),
          ),
        ),
      );

      final gestureDetector = find.byWidgetPredicate(
        (Widget widget) =>
            widget is Row &&
            widget.children
                .any((child) => child is Expanded && child.child is Text),
      );
      final checkBox = find.descendant(
        of: gestureDetector,
        matching:
            find.textContaining('I am authorizing Texas Farm Bureau Insurance'),
      );
      await tester.tap(checkBox);
      await tester.pumpAndSettle();

      expect(
        find.widgetWithText(
          TfbFilledButton,
          AppLocalizationsEn().discontinueAndDelete,
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (w) => w is TfbFilledButton && w.enabled == true,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Cancel buttom is on AppBar', (tester) async {
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockTfbNavigator,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: BlocProvider<AutopayBloc>(
            create: (context) => AutopayBloc(repository: repo),
            child: DiscontinueAutoPayEnrollmentPage(policy: mockPolicy),
          ),
        ),
      );

      final finderTfbAnimatedAppBar = find.byType(TfbAnimatedAppBar);
      final widgetTfbAnimatedAppBar =
          tester.widget<TfbAnimatedAppBar>(finderTfbAnimatedAppBar);
      expect(widgetTfbAnimatedAppBar.showCancelButton, isTrue);
    });

    testWidgets('Cancel buttom is pressed and pop is called', (tester) async {
      when(() => mockTfbNavigator.pop())
          .thenAnswer((_) => Future<Object?>.value());
      await tester.pumpWidget(
        TfbWidgetTester(
          mockNavigator: mockTfbNavigator,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: BlocProvider<AutopayBloc>(
            create: (context) => AutopayBloc(repository: repo),
            child: DiscontinueAutoPayEnrollmentPage(policy: mockPolicy),
          ),
        ),
      );

      final finderCancelButton = find.byType(
        CancelAppBarAction,
      );
      await tester.tap(finderCancelButton);
      await tester.pumpAndSettle();
      verify(() => mockTfbNavigator.pop()).called(1);
    });
  });
}
