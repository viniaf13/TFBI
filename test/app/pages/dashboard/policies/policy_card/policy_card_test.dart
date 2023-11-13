import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/personal_auto_policy_vehicle_list.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policies_section.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/policies/policy_card/policy_card_address.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';

import '../../../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../../mocks/mock_vehicle.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
  late PolicySummary mockPolicySummary;
  late AutoPolicyDetail mockAutoPolicyDetail;
  late MockClaimsBloc mockClaimsBloc;
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

  testWidgets(
    'Should display PolicyCard and Vehicle List when there is a '
    'Personal Auto Policy',
    (WidgetTester tester) async {
      mockPolicySummary = MockPolicy.createPolicySummary(
        policyType: PolicyType.txPersonalAuto,
      );

      mockAutoPolicyDetail = MockPolicy.createAutoPolicyDetail(
        policyNum: mockPolicySummary.policyNumber,
      );

      mockAutoPolicyDetail.vehicles.clear();
      mockAutoPolicyDetail.vehicles.add(MockVehicles.generateRandomVehicle());

      await tester.pumpWidget(
        TfbWidgetTester(
          child: SizedBox(
            height: 800,
            child: BlocProvider<ClaimsBloc>.value(
              value: mockClaimsBloc,
              child: PolicyCard(
                mockPolicySummary,
                mockAutoPolicyDetail,
              ),
            ),
          ),
        ),
      );

      expect(
        find.text(mockAutoPolicyDetail.vehicles[0].yearMakeModel),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should NOT display policy card and Vehicle list where there is not a '
    'Personal Auto Policy',
    (WidgetTester tester) async {
      mockPolicySummary = MockPolicy.createPolicySummary();

      final mockPolicyDetail = MockPolicy.createHomeownerPolicyDetail();

      mockAutoPolicyDetail = MockPolicy.createAutoPolicyDetail(
        policyNum: mockPolicySummary.policyNumber,
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: SizedBox(
            height: 800,
            child: BlocProvider<ClaimsBloc>.value(
              value: mockClaimsBloc,
              child: PolicyCard(
                mockPolicySummary,
                mockPolicyDetail,
              ),
            ),
          ),
        ),
      );

      expect(
        find.byWidget(PersonalAutoPolicyVehicleList(mockAutoPolicyDetail)),
        findsNothing,
      );
    },
  );

  testWidgets('Homeowner and Ag Advantage cards contain property location',
      (tester) async {
    const location = '123 Street City State 12345 1234';
    final policyDetail = MockPolicy.createHomeownerPolicyDetail(
      propertyLocation: location,
    );
    mockPolicySummary = MockPolicy.createPolicySummary();

    await tester.pumpWidget(
      TfbWidgetTester(
        child: SizedBox(
          height: 800,
          child: BlocProvider<ClaimsBloc>.value(
            value: mockClaimsBloc,
            child: PolicyCard(
              mockPolicySummary,
              policyDetail,
            ),
          ),
        ),
      ),
    );

    expect(
      find.byType(PolicyCardAddress),
      findsOneWidget,
    );
    expect(find.text(location), findsOneWidget);
  });
}
