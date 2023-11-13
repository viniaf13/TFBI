import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/pages.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

import '../../../mocks/mock_member_access_client.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  final TfbMemberAccessClient mockMemberAccessClient = MockMemberAccessClient();
  final TfbNavigator mockTfbNavigator = MockTfbNavigator();

  testWidgets(
      'Clicking the "send email again" button should once again call the request forgot password event and client',
      (tester) async {
    when(() => mockMemberAccessClient.forgotPassword(any())).thenAnswer(
      (invocation) => Future.value(
        TfbGenericApiResponse(
          errorMessage: '',
          returnMessage: '',
        ),
      ),
    );

    const email = 'test@test.com';
    final ForgotPasswordBloc mockBloc =
        ForgotPasswordBloc(memberAccessClient: mockMemberAccessClient)
          ..add(const RequestForgotPasswordEvent(email));

    await tester.pumpWidget(
      TfbWidgetTester(
        mockNavigator: mockTfbNavigator,
        child: BlocProvider(
          create: (context) => mockBloc,
          child: const ForgotPasswordVerifyEmailPage(),
        ),
      ),
    );

    await tester.tap(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is Row,
      ),
    );
    await tester.pumpAndSettle();

    verify(() => mockMemberAccessClient.forgotPassword(email)).called(2);
    verifyNever(() => mockTfbNavigator.goToForgotPasswordVerifyPage(any()));
    expect(mockBloc.state, isA<ForgotPasswordRequestSuccess>());
  });
}
