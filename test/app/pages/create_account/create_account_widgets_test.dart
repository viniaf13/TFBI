import 'package:flutter_test/flutter_test.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/confirm_email_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/confirm_password_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/password_criteria_row.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_account_button.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_email_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_member_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_password_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_policy_num_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/terms_checkbox.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_member_number_validator.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_policy_number_validator.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_stage.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../widgets/tfb_widget_tester.dart';

void main() {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController memberNumController = TextEditingController();
  final TextEditingController policyController = TextEditingController();

  /// Email ///
  testWidgets('ConfirmEmailFormField widget should be created',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ConfirmEmailFormField(confirmEmailController: emailController),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets(
      'ConfirmEmailFormField should receive and display the input correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ConfirmEmailFormField(confirmEmailController: emailController),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'test@example.com');

    await tester.pump();

    expect(find.text('test@example.com'), findsOneWidget);
    expect(emailController.text, 'test@example.com');
  });

  /// Password ///
  testWidgets('ConfirmPasswordFormField widget should be created',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ConfirmPasswordFormField(
            confirmPasswordController: passController,
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets(
      'ConfirmPasswordFormField should receive and obscure the input correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ConfirmPasswordFormField(
            confirmPasswordController: passController,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'password');
    await tester.pump();
    expect(passController.text, 'password');
  });

  testWidgets(
      'ConfirmPasswordFormField should toggle password visibility when icon button is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ConfirmPasswordFormField(
            confirmPasswordController: passController,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'password');

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(find.text('password'), findsOneWidget);
  });

  /// Password Criteria Row ///
  testWidgets(
      'PasswordCriteriaRow should show correct icon and text when criteria is met',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: Scaffold(
          body: PasswordCriteriaRow(
            isCriteriaMet: true,
            labelText: 'Criteria Met',
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color ==
                LightColors.greenHighLight,
      ),
      findsOneWidget,
    );
    expect(find.text('Criteria Met'), findsOneWidget);
  });

  testWidgets(
      'PasswordCriteriaRow should show correct icon and text when criteria is not met',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const TfbWidgetTester(
        child: Scaffold(
          body: PasswordCriteriaRow(
            isCriteriaMet: false,
            labelText: 'Criteria Not Met',
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color ==
                TfbBrandColors.grayHigh,
      ),
      findsOneWidget,
    );
    expect(find.text('Criteria Not Met'), findsOneWidget);
  });

  /// Register Account Button ///
  testWidgets('RegisterAccountButton should be created',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterAccountButton(onPressed: () {}),
        ),
      ),
    );

    expect(find.byType(TfbFilledButton), findsOneWidget);
  });

  testWidgets(
      'RegisterAccountButton should call the onPressed callback when pressed',
      (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterAccountButton(
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TfbFilledButton));
    await tester.pump();

    expect(onPressedCalled, isTrue);
  });

  /// Register Email Field ///
  testWidgets('RegisterEmailFormField should be created',
      (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterEmailFormField(
            registerEmailController: controller,
            labelText: 'Email',
            onChange: (_) {},
            validator: TfbEmailValidator(errorMessageMap: {}),
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('RegisterEmailFormField should display the correct label',
      (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterEmailFormField(
            registerEmailController: controller,
            labelText: 'Email',
            onChange: (_) {},
            validator: TfbEmailValidator(errorMessageMap: {}),
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('RegisterEmailFormField should validate the input',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: Form(
            key: formKey,
            child: RegisterEmailFormField(
              registerEmailController: controller,
              labelText: 'Email',
              onChange: (_) {},
              validator: TfbEmailValidator(
                errorMessageMap: {
                  EmailValidatorErrorMessageKeys.noEmailFound:
                      'Please enter some text',
                },
              ),
            ),
          ),
        ),
      ),
    );

    final field = find.byType(TextFormField);

    await tester.enterText(field, '');
    await tester.pump();

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Please enter some text'), findsOneWidget);

    await tester.enterText(field, 'test@example.com');
    await tester.pump();

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Please enter some text'), findsNothing);
  });

  /// Member Number Form Field
  testWidgets('MemberNumberFormField should not be empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: MemberNumberFormField(
            memberNumController: memberNumController,
            onChanged: (_) {},
            validator: TfbMemberNumberValidator(errorMessageMap: {}),
          ),
        ),
      ),
    );

    expect(find.byType(MemberNumberFormField), findsOneWidget);
  });

  testWidgets('TextFormField exists in the widget tree',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: MemberNumberFormField(
            memberNumController: memberNumController,
            onChanged: (_) {},
            validator: TfbMemberNumberValidator(errorMessageMap: {}),
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Input changes when user types into the TextFormField',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: MemberNumberFormField(
            memberNumController: memberNumController,
            onChanged: (_) {},
            validator: TfbMemberNumberValidator(errorMessageMap: {}),
          ),
        ),
      ),
    );

    final field = find.byType(TextFormField);
    await tester.enterText(field, '123456');
    expect(memberNumController.text, '123456');
  });

  testWidgets('IconButton can be found and tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: MemberNumberFormField(
            memberNumController: memberNumController,
            onChanged: (_) {},
            validator: TfbMemberNumberValidator(errorMessageMap: {}),
          ),
        ),
      ),
    );

    final button = find.byType(IconButton);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
  });

  /// Password Form Field ///
  testWidgets('RegisterPasswordFormField should not be empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterPasswordFormField(
            registerPasswordController: passController,
            labelText: 'Password',
            onChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.byType(RegisterPasswordFormField), findsOneWidget);
  });

  testWidgets('TextFormField exists in the widget tree',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterPasswordFormField(
            registerPasswordController: passController,
            labelText: 'Password',
            onChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Input changes when user types into the TextFormField',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterPasswordFormField(
            registerPasswordController: passController,
            labelText: 'Password',
            onChanged: (_) {},
          ),
        ),
      ),
    );

    final field = find.byType(TextFormField);
    await tester.enterText(field, 'password123');
    expect(passController.text, 'password123');
  });

  testWidgets('IconButton can be found and tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: RegisterPasswordFormField(
            registerPasswordController: passController,
            labelText: 'Password',
            onChanged: (_) {},
          ),
        ),
      ),
    );

    final button = find.byType(IconButton);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
  });

  /// Policy Number Form Field ///
  testWidgets('PolicyNumberFormField should not be empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: PolicyNumberFormField(
            policyNumController: policyController,
            onChanged: (_) {},
            policyNumberValidator: TfbPolicyNumberValidator(
              errorMessageMap: {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(PolicyNumberFormField), findsOneWidget);
  });

  testWidgets('TextFormField exists in the widget tree',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: PolicyNumberFormField(
            policyNumController: policyController,
            onChanged: (_) {},
            policyNumberValidator: TfbPolicyNumberValidator(
              errorMessageMap: {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Input changes when user types into the TextFormField',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: PolicyNumberFormField(
            policyNumController: policyController,
            onChanged: (_) {},
            policyNumberValidator: TfbPolicyNumberValidator(
              errorMessageMap: {},
            ),
          ),
        ),
      ),
    );

    final field = find.byType(TextFormField);
    await tester.enterText(field, '12345');
    expect(policyController.text, '12345');
  });

  bool termsChecked = false;

  void onChanged({bool? value}) {
    termsChecked = value ?? false;
  }

  /// Terms Check Box ///
  testWidgets('TermsCheckbox should not be empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
        child: Scaffold(
          body: TermsCheckbox(
            termsChecked: termsChecked,
            onChanged: onChanged,
          ),
        ),
      ),
    );

    expect(find.byType(TermsCheckbox), findsOneWidget);
  });

  testWidgets('Checkbox exists in the widget tree',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
        child: Scaffold(
          body: TermsCheckbox(
            termsChecked: termsChecked,
            onChanged: onChanged,
          ),
        ),
      ),
    );

    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets('Checkbox status changes when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
        child: Scaffold(
          body: TermsCheckbox(
            termsChecked: termsChecked,
            onChanged: onChanged,
          ),
        ),
      ),
    );

    final checkbox = find.byType(Checkbox);
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(termsChecked, isTrue);
  });

  testWidgets('Validator works as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockEnvironment: TfbEnvironmentStage(),
        child: Scaffold(
          body: TermsCheckbox(
            termsChecked: false,
            onChanged: onChanged,
          ),
        ),
      ),
    );

    final checkbox = find.byType(Checkbox);
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(find.text('You must agree to the terms.'), findsNothing);
  });
}
