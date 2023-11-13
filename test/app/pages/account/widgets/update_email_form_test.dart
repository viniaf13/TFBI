import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_email/update_email_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/update_email_form.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/update_email_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../device/tfb_secure_storage_test.dart';
import '../../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../../mocks/mock_member_access_client.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
      UpdateEmailRequest(
        memberNumber: '',
        newUserName: '',
        oldUserName: '',
      ),
    );
  });

  testWidgets(
    'An invalid email in the update email form should show an error',
    (tester) async {
      const errorString = 'ERROR';
      const invalidEmail = 'test@test.';
      final TextEditingController controller = TextEditingController();
      final TfbEmailValidator validator = TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              errorString,
        },
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: UpdateEmailForm(
              emailController: controller,
              emailValidator: validator,
              isEmailValidNotifier: ValueNotifier(false),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), invalidEmail);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text(errorString), findsOneWidget);
    },
  );

  testWidgets(
    'An valid email in the update email form should show no error message and enable the CTA',
    (tester) async {
      const errorString = 'ERROR';
      const validEmail = 'test@test.com';
      final TextEditingController controller = TextEditingController();
      final TfbEmailValidator validator = TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              errorString,
        },
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: Scaffold(
            body: UpdateEmailForm(
              emailController: controller,
              emailValidator: validator,
              isEmailValidNotifier: ValueNotifier(false),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), validEmail);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text(errorString), findsNothing);
      expect(
        find.byWidgetPredicate(
          (widget) => widget is TfbFilledButton && widget.onPressed != null,
        ),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Submitting a valid email should call the update email API',
    (tester) async {
      const errorString = 'ERROR';
      const validEmail = 'test@test.com';
      final TextEditingController controller = TextEditingController();
      final TfbEmailValidator validator = TfbEmailValidator(
        errorMessageMap: {
          EmailValidatorErrorMessageKeys.emailNotCorrectlyFormatted:
              errorString,
        },
      );
      final TfbMemberAccessClient mockMemberAccessClient =
          MockMemberAccessClient();
      when(() => mockMemberAccessClient.updateEmail(any())).thenAnswer(
        (invocation) => Future.value(
          TfbGenericApiResponse(errorMessage: '', returnMessage: ''),
        ),
      );

      final AuthBloc mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));

      await tester.pumpWidget(
        TfbWidgetTester(
          mockAuthBloc: mockAuthBloc,
          child: Provider.value(
            value: mockMemberAccessClient,
            child: BlocProvider(
              create: (context) => UpdateEmailCubit(),
              child: Scaffold(
                body: UpdateEmailForm(
                  emailController: controller,
                  emailValidator: validator,
                  isEmailValidNotifier: ValueNotifier(false),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), validEmail);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TfbFilledButton));
      await tester.pumpAndSettle();

      verify(() => mockMemberAccessClient.updateEmail(any())).called(1);
    },
  );
}
