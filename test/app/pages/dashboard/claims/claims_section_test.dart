import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/dashboard.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_failure_container.dart';

import '../../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
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

  final claimsList = [claimPersonalAuto, claimHomeOwners, claimPersonalAuto];

  setUp(() {
    mockClaimsBloc = MockClaimsBloc();
  });

  testWidgets('ClaimsSectionBody displays correctly with empty claims list',
      (WidgetTester tester) async {
    final List<FullClaim> emptyClaimsList = [];
    when(() => mockClaimsBloc.state)
        .thenReturn(ClaimSuccessState(fullClaimsList: emptyClaimsList));

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const ClaimsSectionBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No active claims'), findsOneWidget);
    expect(find.text('File a claim'), findsOneWidget);
    expect(find.text('View Claims'), findsOneWidget);
  });

  testWidgets('ClaimsSectionBody displays correctly with 2 claims',
      (WidgetTester tester) async {
    when(() => mockClaimsBloc.state)
        .thenReturn(ClaimSuccessState(fullClaimsList: claimsList.sublist(1)));

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const ClaimsSectionBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('#${claimHomeOwners.claimNumber!}'), findsOneWidget);
    expect(find.text('#${claimPersonalAuto.claimNumber!}'), findsOneWidget);
    expect(find.text('+1 more claims'), findsNothing);
  });

  testWidgets('ClaimsSectionBody displays correctly with 3 claims',
      (WidgetTester tester) async {
    when(() => mockClaimsBloc.state)
        .thenReturn(ClaimSuccessState(fullClaimsList: claimsList));

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const ClaimsSectionBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('#${claimHomeOwners.claimNumber!}'), findsOneWidget);
    expect(find.text('#${claimPersonalAuto.claimNumber!}'), findsOneWidget);
    expect(find.text('+1 more claims'), findsOneWidget);
  });

  testWidgets('Claims section displays error message on api failure',
      (WidgetTester tester) async {
    when(() => mockClaimsBloc.state).thenReturn(
      ClaimsFailureState(error: TfbRequestError()),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const ClaimsSectionBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(DecoratedFailureContainer), findsOneWidget);
  });
}
