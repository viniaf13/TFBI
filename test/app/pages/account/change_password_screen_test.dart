import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/change_password/change_password_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/change_password.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../widgets/tfb_widget_tester.dart';

class MockChangePasswordCubit extends MockCubit<ChangePasswordState>
    implements ChangePasswordCubit {}

void main() {
  late ChangePasswordScreen changePasswordScreen;
  late MockChangePasswordCubit mockChangePasswordCubit;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  setUp(() {
    mockChangePasswordCubit = MockChangePasswordCubit();
    changePasswordScreen = const ChangePasswordScreen();

    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  group('ChangePasswordScreen', () {
    testWidgets('shows initial state', (WidgetTester tester) async {
      when(() => mockChangePasswordCubit.state)
          .thenReturn(ChangePasswordInitial());
      await tester.pumpWidget(
        BlocProvider<ChangePasswordCubit>.value(
          value: mockChangePasswordCubit,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            child: changePasswordScreen,
          ),
        ),
      );
      // Expect the ChangePasswordScreen widget to be present.
      expect(find.byType(ChangePasswordScreen), findsOneWidget);

      // Expect the filled button to be present but disabled.
      final findButton = find.byType(TfbFilledButton);
      expect(findButton, findsOneWidget);
      expect(tester.widget<TfbFilledButton>(findButton).enabled, isFalse);
    });

    testWidgets('shows success state', (WidgetTester tester) async {
      when(() => mockChangePasswordCubit.state)
          .thenReturn(ChangePasswordSuccess());
      await tester.pumpWidget(
        BlocProvider<ChangePasswordCubit>.value(
          value: mockChangePasswordCubit,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            child: changePasswordScreen,
          ),
        ),
      );
      // Expect the ChangePasswordScreen widget to be present.
      expect(find.byType(ChangePasswordScreen), findsOneWidget);

      await tester.pump();

      // Expect the filled button to be present and enabled.
      final findButton = find.byType(TfbFilledButton);
      expect(findButton, findsOneWidget);
    });

    testWidgets('shows failure state', (WidgetTester tester) async {
      when(() => mockChangePasswordCubit.state)
          .thenReturn(ChangePasswordFailure(error: TfbRequestError()));
      await tester.pumpWidget(
        BlocProvider<ChangePasswordCubit>.value(
          value: mockChangePasswordCubit,
          child: TfbWidgetTester(
            mockStatusBarScrollCubit: mockStatusBarScrollCubit,
            child: changePasswordScreen,
          ),
        ),
      );
      // Expect the ChangePasswordScreen widget to be present.
      expect(find.byType(ChangePasswordScreen), findsOneWidget);

      // Expect the filled button to be present and disabled.
      final findButton = find.byType(TfbFilledButton);
      expect(findButton, findsOneWidget);
      expect(tester.widget<TfbFilledButton>(findButton).enabled, isFalse);
    });
  });
}
