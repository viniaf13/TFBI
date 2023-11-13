import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/dashboard/quick_access/widgets/quick_access_insurance_card.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/member_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/widgets/decorated_container_with_loading.dart';

import '../../../../mocks/mock_member_summary.dart';
import '../../../../mocks/mock_policy_lookup_client.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockMemberSummaryCubit memberSummaryCubit;

  setUp(() {
    memberSummaryCubit = MockMemberSummaryCubit();
  });

  group('QuickAccessInsuranceCard Widget Tests', () {
    testWidgets('renders loading container when state is initial',
        (WidgetTester tester) async {
      when(() => memberSummaryCubit.state).thenReturn(
        MemberSummaryInitial(),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<MemberSummaryCubit>(
            create: (_) => memberSummaryCubit,
            child: const Row(
              children: [
                QuickAccessInsuranceCard(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DecoratedContainerWithLoading), findsOneWidget);
    });

    testWidgets('renders view ID card when there is more than one policy',
        (WidgetTester tester) async {
      when(() => memberSummaryCubit.state).thenReturn(
        MemberSummaryDetailsSuccess(
          memberSummary: MemberSummary(
            policies: [
              MockPolicy.createPolicySummary(
                policyType: PolicyType.txPersonalAuto,
              ),
            ],
          ),
          policyMap: {
            '00000': MockPolicy.createHomeownerPolicyDetail(),
          },
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<MemberSummaryCubit>(
            create: (_) => memberSummaryCubit,
            child: const Row(
              children: [
                QuickAccessInsuranceCard(),
              ],
            ),
          ),
        ),
      );

      expect(find.text(AppLocalizationsEn().viewIdCard), findsOneWidget);
    });

    testWidgets('renders view ID card for a single policy',
        (WidgetTester tester) async {
      when(() => memberSummaryCubit.state).thenReturn(
        MemberSummaryDetailsSuccess(
          memberSummary: MemberSummary(
            policies: [
              MockPolicy.createPolicySummary(
                policyType: PolicyType.txPersonalAuto,
              ),
            ],
          ),
          policyMap: {
            '00000': MockPolicy.createHomeownerPolicyDetail(),
          },
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<MemberSummaryCubit>(
            create: (_) => memberSummaryCubit,
            child: const Row(
              children: [
                QuickAccessInsuranceCard(),
              ],
            ),
          ),
        ),
      );

      expect(find.text(AppLocalizationsEn().viewIdCard), findsOneWidget);
    });

    testWidgets('renders file a claim CTA', (WidgetTester tester) async {
      when(() => memberSummaryCubit.state).thenReturn(
        MemberSummaryDetailsSuccess(
          memberSummary: MemberSummary(
            policies: [
              MockPolicy.createPolicySummary(),
            ],
          ),
          policyMap: {
            '00000': MockPolicy.createHomeownerPolicyDetail(),
          },
        ),
      );

      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<MemberSummaryCubit>(
            create: (_) => memberSummaryCubit,
            child: const Row(
              children: [
                QuickAccessInsuranceCard(),
              ],
            ),
          ),
        ),
      );

      expect(
        find.text(AppLocalizationsEn().claimsFileAClaimCTA),
        findsOneWidget,
      );
    });
  });
}
