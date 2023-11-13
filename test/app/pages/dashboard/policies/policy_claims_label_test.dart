import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_claims_label.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockClaimsBloc mockClaimsBloc;
  late PolicySummary mockPolicySummary;

  final FullClaim claimPersonalAuto = FullClaim(
    policyType: PolicyType.txPersonalAuto,
    statusEnum: ClaimStatusEnum.active,
    claimNumber: '123456',
    policyNumber: '1234567',
    dateOfLoss: '01/01/2023',
    claimDetails: null,
  );

  final FullClaim claimHomeOwners = FullClaim(
    policyType: PolicyType.homeowners,
    statusEnum: ClaimStatusEnum.active,
    claimNumber: '654321',
    policyNumber: '1234567',
    dateOfLoss: '01/01/2023',
    claimDetails: null,
  );

  final claimsList = [claimPersonalAuto, claimHomeOwners];

  setUp(() {
    mockClaimsBloc = MockClaimsBloc();

    when(() => mockClaimsBloc.state).thenReturn(
      ClaimSuccessState(
        fullClaimsList: claimsList,
      ),
    );
  });

  testWidgets('PolicyClaimsLabel shows claim count when there are open claims',
      (tester) async {
    mockPolicySummary = MockPolicy.createPolicySummary(
      policyNumber: '1234567',
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: PolicyClaimsLabel(
            policySummary: mockPolicySummary,
          ),
        ),
      ),
    );

    expect(find.textContaining('This policy has 2 open claim'), findsOneWidget);
    expect(find.byType(SizedBox), findsNothing);
  });

  testWidgets('PolicyClaimsLabel hides when there are no open claims',
      (tester) async {
    mockPolicySummary = MockPolicy.createPolicySummary(
      policyNumber: '123',
    );
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: PolicyClaimsLabel(
            policySummary: mockPolicySummary,
          ),
        ),
      ),
    );

    expect(find.byType(Text), findsNothing);
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
