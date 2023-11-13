import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/registration_resend/registration_resend_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification/widgets/registration_resend_snackbar_listener.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_snackbar_content.dart';

import '../../../../mocks/mock_member_access_client.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  final defaultRegistrationRequest = RegistrationResendRequest(
    communicationOption: 'communicationOption',
    emailAddress: 'emailAddress',
    memberNumber: 'memberNumber',
    password: 'password',
    policyNumber: 'policyNumber',
  );

  late TfbMemberAccessClient mockMemberAccessClient;
  late RegistrationResendCubit cubit;

  setUp(() {
    registerFallbackValue(defaultRegistrationRequest);

    mockMemberAccessClient = MockMemberAccessClient();
    cubit = RegistrationResendCubit(mockMemberAccessClient);
  });

  testWidgets('Emitting a RegistrationResendError will show an error snackbar',
      (tester) async {
    when(() => mockMemberAccessClient.registerResend(any())).thenAnswer(
      (invocation) => Future.value(
        TfbGenericApiResponse(
          errorMessage: 'Error',
          returnMessage: '',
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => cubit,
          child: TfbWidgetTester(
            child: ScaffoldMessenger(
              child: Scaffold(
                body: Stack(
                  children: [
                    const RegistrationResendSnackbarListener(),
                    Builder(
                      builder: (context) {
                        context
                            .read<RegistrationResendCubit>()
                            .resendRegistration(defaultRegistrationRequest);

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(
      find.byType(TfbSnackbarContent, skipOffstage: false),
      findsOneWidget,
    );
  });

  testWidgets(
      'Emitting a RegistrationResendSuccess will show an success snackbar',
      (tester) async {
    when(() => mockMemberAccessClient.registerResend(any())).thenAnswer(
      (invocation) => Future.value(
        TfbGenericApiResponse(
          errorMessage: '',
          returnMessage: 'Return message',
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => cubit,
          child: TfbWidgetTester(
            child: ScaffoldMessenger(
              child: Scaffold(
                body: Stack(
                  children: [
                    const RegistrationResendSnackbarListener(),
                    Builder(
                      builder: (context) {
                        context
                            .read<RegistrationResendCubit>()
                            .resendRegistration(defaultRegistrationRequest);

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));

    expect(
      find.byType(TfbSnackbarContent, skipOffstage: false),
      findsOneWidget,
    );
  });
}
