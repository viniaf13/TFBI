import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/forgot_password/forgot_password_page.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../mocks/mock_member_access_client.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  final TfbMemberAccessClient mockMemberAccessClient = MockMemberAccessClient();
  final TfbNavigator mockTfbNavigator = MockTfbNavigator();

  testWidgets(
      'Submitting the email form field with no text should show error text',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockTfbNavigator,
        child: BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient),
          child: ForgotPasswordPage(),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().emailEmptyForgotPassword),
      findsOneWidget,
    );
  });

  testWidgets(
      'Submitting the email form field with an invalid email should show error text',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockTfbNavigator,
        child: BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient),
          child: ForgotPasswordPage(),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField));
    await tester.enterText(find.byType(TextFormField), 'test@test');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(
      find.text(AppLocalizationsEn().emailInvalidForgotPassword),
      findsOneWidget,
    );
  });

  testWidgets(
      'Tapping on the submit button and getting an API error should display the error on the page',
      (tester) async {
    const errorMessage = 'ERROR_MESSAGE';
    const email = 'liam@mcmains.net';

    final ForgotPasswordBloc mockBloc =
        ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient);

    when(() => mockMemberAccessClient.forgotPassword(any())).thenAnswer(
      (invocation) => Future.value(
        TfbGenericApiResponse(
          errorMessage: errorMessage,
          returnMessage: '',
        ),
      ),
    );

    when(() => mockTfbNavigator.location)
        .thenReturn(TfbAppRoutes.forgotPassword.absolutePath);

    when(() => mockTfbNavigator.goToForgotPasswordVerifyPage(any()))
        .thenAnswer((invocation) => Future<void>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockTfbNavigator,
        child: BlocProvider(
          create: (context) => mockBloc,
          child: ForgotPasswordPage(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), email);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(TfbFilledButton));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(mockBloc.state, isA<ForgotPasswordRequestError>());
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets(
      'Tapping on the submit button with a valid email should call the forgot password request bloc and move to the next screen',
      (tester) async {
    const email = 'test@test.com';
    final ForgotPasswordBloc mockBloc =
        ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient);

    when(() => mockMemberAccessClient.forgotPassword(any())).thenAnswer(
      (invocation) => Future.value(
        TfbGenericApiResponse(
          errorMessage: '',
          returnMessage: '',
        ),
      ),
    );

    when(() => mockTfbNavigator.location)
        .thenReturn(TfbAppRoutes.forgotPassword.absolutePath);

    when(() => mockTfbNavigator.goToForgotPasswordVerifyPage(any()))
        .thenAnswer((invocation) => Future<void>.value());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockTfbNavigator,
        child: BlocProvider(
          create: (context) => mockBloc,
          child: ForgotPasswordPage(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), email);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(TfbFilledButton));
    await tester.pumpAndSettle();

    verify(() => mockMemberAccessClient.forgotPassword(email)).called(1);
    verify(() => mockTfbNavigator.goToForgotPasswordVerifyPage(any()))
        .called(1);
    expect(mockBloc.state, isA<ForgotPasswordRequestSuccess>());
  });
}
