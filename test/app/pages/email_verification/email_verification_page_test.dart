import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification/email_verification_page.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../mocks/mock_member_access_client.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  setUp(() {
    registerFallbackValue(
      RegistrationResendRequest(
        communicationOption: 'communicationOption',
        emailAddress: 'emailAddress',
        memberNumber: 'memberNumber',
        password: 'password',
        policyNumber: 'policyNumber',
      ),
    );
  });

  testWidgets(
      'Tapping on the resend button will submit a registration resend event',
      (tester) async {
    final request = RegistrationResendRequest(
      communicationOption: 'communicationOption',
      emailAddress: 'emailAddress',
      memberNumber: 'memberNumber',
      password: 'password',
      policyNumber: 'policyNumber',
    );

    final authClient = MockMemberAccessClient();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: EmailVerificationPage(
          memberAccessClient: authClient,
          resendInformation: request,
        ),
      ),
    );

    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is Row,
      ),
    );
    await tester.pumpAndSettle();

    verify(() => authClient.registerResend(any())).called(1);
  });

  testWidgets(
      'Tapping on the resend button will only make the API call once even if its tapped more than once while processing',
      (tester) async {
    final request = RegistrationResendRequest(
      communicationOption: 'communicationOption',
      emailAddress: 'emailAddress',
      memberNumber: 'memberNumber',
      password: 'password',
      policyNumber: 'policyNumber',
    );

    final memberAccessClient = MockMemberAccessClient();

    when(() => memberAccessClient.registerResend(any()))
        .thenAnswer((invocation) async {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return TfbGenericApiResponse(errorMessage: '', returnMessage: '');
    });

    await tester.pumpWidget(
      TfbWidgetTester(
        child: EmailVerificationPage(
          memberAccessClient: memberAccessClient,
          resendInformation: request,
        ),
      ),
    );

    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is Row,
      ),
    );
    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is Row,
      ),
    );
    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is Row,
      ),
    );
    await tester.pumpAndSettle();

    verify(() => memberAccessClient.registerResend(any())).called(1);
  });
}
