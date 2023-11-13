import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/widgets/autopay_enrollment_button.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/account_info_form_data.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/autopay_form_state.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_filled_button.dart';

import '../../../../../device/tfb_secure_storage_test.dart';
import '../../../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../../../widgets/tfb_widget_tester.dart';
import '../../../policy_detail/widgets/insurance_card_content_test.dart';

void main() {
  final policy = MockPolicySummary();

  testWidgets('If button is in invalid state then button is disabled',
      (tester) async {
    when(() => policy.isAutoPayEnabled).thenAnswer((invocation) => true);
    await tester.pumpWidget(
      TfbWidgetTester(
        child: AutopayEnrollmentButton(
          isFormValid: false,
          areTermsChecked: false,
          draftDay: '',
          policy: policy,
          accountType: AutopayAccountType.unknown,
          accountInfo: AccountInfoFormData.empty(),
        ),
      ),
    );
    final submitButton = find.byWidgetPredicate(
      (widget) => widget is TfbFilledButton && widget.onPressed == null,
    );
    expect(submitButton, findsOneWidget);
  });

  testWidgets('If button parameters are valid then button is enabled',
      (tester) async {
    final AuthBloc mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(testUser));
    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        child: AutopayEnrollmentButton(
          isFormValid: true,
          areTermsChecked: true,
          draftDay: '1',
          policy: policy,
          accountType: AutopayAccountType.checkings,
          accountInfo: const AccountInfoFormData(
            bankAccountName: 'bankAccountName',
            routingNumber: 'routingNumber',
            bankAccountNumber: 'bankAccountNumber',
            bankName: 'bankName',
          ),
        ),
      ),
    );
    final submitButton = find.byWidgetPredicate(
      (widget) => widget is TfbFilledButton && widget.onPressed != null,
    );
    expect(submitButton, findsOneWidget);
  });
}
