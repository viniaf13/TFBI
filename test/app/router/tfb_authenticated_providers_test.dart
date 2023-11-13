import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:plugin_haven/environment/environment_provider.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_authenticated_providers.dart';
import 'package:txfb_insurance_flutter/domain/models/login/login_member.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../mocks/bloc/mock_auth_bloc.dart';

void main() {
  testWidgets(
      'tfb authenticated service provider correctly provides policy lookup repository.',
      (tester) async {
    final tfbUser = TfbUser(
      accessToken: 'accessToken',
      username: 'username',
      agentNumber: 'agentNumber',
      communicationPreferred: 'communicationPreferred',
      emailVerified: false,
      errorMessage: 'errorMessage',
      memberName: 'memberName',
      memberSecondaryName: 'memberSecondaryName',
      passwordResetFlag: false,
      sessionCookie: 'sessionCookie',
      members: [
        LoginMember(
          lastLoginTimestamp: 'lastLoginTimestamp',
          memberIDNumber: 1234,
          memberNumber: 'memberNumber',
        ),
      ],
      memberEmailAddress: 'memberEmailAddress',
    );
    final AuthBloc mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthSignedIn(tfbUser));

    await tester.pumpWidget(
      BlocProvider.value(
        value: mockAuthBloc,
        child: EnvironmentProvider(
          defaultEnvironment: TfbEnvironmentDev(),
          child: TfbAuthenticatedProviders(
            Builder(
              builder: (context) {
                final lookupClient = context.read<TfbPolicyLookupRepository>();
                expect(lookupClient, isNotNull);

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  });
}
