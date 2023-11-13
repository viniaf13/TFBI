import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_card_title.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_detail_claims_card/policy_detail_claims_card.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/domain/models/models.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/enum/claim_status_enum.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

import '../../../../../mocks/bloc/mock_claims_bloc.dart';
import '../../../../../mocks/mock_tfb_navigator.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

void main() {
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

  late MockClaimsBloc mockClaimsBloc;
  late MockTfbNavigator mockNavigator;

  setUp(() {
    mockClaimsBloc = MockClaimsBloc();
    mockNavigator = MockTfbNavigator();
  });

  Widget buildTestableWidget(Widget widget) {
    return TfbWidgetTester(
      mockNavigator: mockNavigator,
      child: widget,
    );
  }

  testWidgets('Renders error container when state is ClaimsFailureState',
      (tester) async {
    when(() => mockClaimsBloc.state).thenReturn(
      ClaimsFailureState(
        error: TfbRequestError(),
      ),
    );

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const PolicyDetailClaimsCard(),
        ),
      ),
    );

    expect(find.text('Error loading claims'), findsOneWidget);
  });

  testWidgets('Renders appropriate widgets when claimsList is empty',
      (tester) async {
    final List<FullClaim> emptyClaimsList = [];
    when(() => mockClaimsBloc.state)
        .thenReturn(ClaimSuccessState(fullClaimsList: emptyClaimsList));

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const PolicyDetailClaimsCard(),
        ),
      ),
    );

    expect(find.text('No active claims'), findsOneWidget);
    expect(find.byType(PolicyDetailCardTitle), findsOneWidget);
    expect(find.byType(TfbFilledButton), findsNothing);
  });

  testWidgets('Renders appropriate widgets when claimsList is not empty',
      (tester) async {
    when(() => mockClaimsBloc.state)
        .thenReturn(ClaimSuccessState(fullClaimsList: claimsList));

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const PolicyDetailClaimsCard(),
        ),
      ),
    );

    expect(find.text('3 Active Claims'), findsOneWidget);
    expect(find.byType(TfbFilledButton), findsOneWidget);
  });

  testWidgets('Tapping on Button should navigate to claims details page',
      (tester) async {
    when(() => mockClaimsBloc.state)
        .thenReturn(ClaimSuccessState(fullClaimsList: claimsList));
    when(() => mockNavigator.goToClaimsDetailsPage()).thenAnswer((_) {});

    await tester.pumpWidget(
      buildTestableWidget(
        BlocProvider<ClaimsBloc>.value(
          value: mockClaimsBloc,
          child: const PolicyDetailClaimsCard(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(TfbFilledButton).last);

    verify(() => mockNavigator.goToClaimsDetailsPage()).called(1);
  });
}
