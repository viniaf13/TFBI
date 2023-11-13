import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/forgot_password_verify/forgot_password_verify_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_password_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password_update/forgot_password_update_page.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password_update/update_password_button.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../widgets/tfb_widget_tester.dart';

class MockForgotPasswordVerifyCubit extends Mock
    implements ForgotPasswordVerifyCubit {}

class MockTfbNavigator extends Mock implements TfbNavigator {}

void main() {
  late MockForgotPasswordVerifyCubit mockCubit;
  late MockTfbNavigator mockNavigator;

  setUp(() {
    mockCubit = MockForgotPasswordVerifyCubit();
    mockNavigator = MockTfbNavigator();
    registerFallbackValue(
      UpdatedPasswordSubmission(
        verificationCode: '123',
        emailAddress: 'test@test.com',
        password: 'password',
      ),
    );
  });

  Widget buildTestableWidget(Widget widget) {
    return TfbWidgetTester(
      child: MultiProvider(
        providers: [
          Provider<ForgotPasswordVerifyCubit>.value(value: mockCubit),
          Provider<TfbNavigator>.value(value: mockNavigator),
        ],
        child: widget,
      ),
    );
  }

  testWidgets(
      'When navigating to forgot password, then ForgotPasswordUpdatePage loads correctly',
      (WidgetTester tester) async {
    when(() => mockCubit.state).thenReturn(ForgotPasswordVerifyInitial());
    when(() => mockCubit.stream)
        .thenAnswer((_) => const Stream<ForgotPasswordVerifyState>.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        BlocBuilder<ForgotPasswordVerifyCubit, ForgotPasswordVerifyState>(
          bloc: mockCubit,
          builder: (context, state) {
            return ForgotPasswordUpdatePage(
              resetToken: '123',
              resetEmail: 'test@test.com',
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    final passwordTextFinder = find.descendant(
      of: find.byType(ForgotPasswordUpdatePage),
      matching: find.text(AppLocalizationsEn().newPassword),
    );

    expect(passwordTextFinder, findsOneWidget);
    expect(find.text(AppLocalizationsEn().confirmNewPassword), findsOneWidget);
    expect(
      find.byType(UpdatePasswordButton, skipOffstage: false),
      findsOneWidget,
    );
  });

  testWidgets(
      'When user is entering their new password, then ForgotPasswordUpdatePage updates password fields and validation is true',
      (WidgetTester tester) async {
    final forgotPasswordPage = ForgotPasswordUpdatePage(
      resetToken: '123',
      resetEmail: 'test@test.com',
    );

    when(() => mockCubit.state).thenReturn(ForgotPasswordVerifyInitial());
    when(() => mockCubit.stream)
        .thenAnswer((_) => const Stream<ForgotPasswordVerifyState>.empty());

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider.value(
          value: mockCubit,
          child: forgotPasswordPage,
        ),
      ),
    );

    await tester.enterText(
      find.byType(RegisterPasswordFormField).first,
      '12345Bottle12345',
    );
    await tester.enterText(
      find.byType(RegisterPasswordFormField).last,
      '12345Bottle12345',
    );
    await tester.pump();

    expect(find.byType(UpdatePasswordButton), findsOneWidget);
    expect(forgotPasswordPage.isValidated.value, isTrue);
  });
}
