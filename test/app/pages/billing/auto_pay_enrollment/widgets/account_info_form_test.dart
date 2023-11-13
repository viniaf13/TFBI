import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/account_info_form.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/account_info_form_data.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/enum/form_validation_type.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

import '../../../../../mocks/mock_tfb_policy_lookup_repository.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  testWidgets('Account form does not become valid until all fields are filled',
      (tester) async {
    final formKey = GlobalKey<FormState>();
    final isFormValid = ValueNotifier(false);
    final accountInfoForm =
        ValueNotifier<AccountInfoFormData>(AccountInfoFormData.empty());
    final TfbPolicyLookupRepository policyLookupRepository =
        MockTfbPolicyLookupRepository();

    when(() => policyLookupRepository.validateRoutingNumber(any()))
        .thenAnswer((invocation) async => r'WELLS FARGO');

    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: BlocProvider(
            create: (context) => RoutingValidationCubit(
              repository: policyLookupRepository,
            ),
            child: AccountInfoForm(
              formKey: formKey,
              isFormValid: isFormValid,
              accountInfoData: accountInfoForm,
            ),
          ),
        ),
      ),
    );

    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.type == ValidationType.bankRoutingNumber,
      ),
      '123123123',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is ValidatingFormField &&
            widget.type == ValidationType.bankAccountName,
      ),
      'JOHN SMITH',
    );
    await tester.enterText(
      find
          .byWidgetPredicate(
            (widget) =>
                widget is ValidatingFormField &&
                widget.type == ValidationType.bankAccountNumber,
          )
          .first,
      '1234567890',
    );
    await tester.enterText(
      find
          .byWidgetPredicate(
            (widget) =>
                widget is ValidatingFormField &&
                widget.type == ValidationType.bankAccountNumber,
          )
          .last,
      '1234567899',
    );

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Bank account numbers don't match
    expect(isFormValid.value, false);

    await tester.enterText(
      find
          .byWidgetPredicate(
            (widget) =>
                widget is ValidatingFormField &&
                widget.type == ValidationType.bankAccountNumber,
          )
          .last,
      '1234567890',
    );

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(isFormValid.value, true);
  });
}
