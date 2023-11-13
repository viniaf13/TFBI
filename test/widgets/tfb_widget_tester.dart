import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/app_update/app_update_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/current_bill/current_billing_doc_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/resources/theme/themes/tfb_typography.dart';
import 'package:txfb_insurance_flutter/shared/utils/tab_tap_notifier.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../app/pages/billing/auto_pay_enrollment_page_test.dart';
import '../app/pages/billing/current_bill_page_test.dart';
import '../app/pages/create_account/create_account_page_test.dart';
import '../mocks/bloc/mock_auth_bloc.dart';
import '../mocks/bloc/mock_biometrics_bloc.dart';
import '../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../mocks/mock_member_summary.dart';
import '../mocks/mock_policy_scroll_cubit.dart';
import '../mocks/mock_submit_claim_bloc.dart';
import '../mocks/mock_tfb_navigator.dart';

/// A material app widget that attempts to provide the necessary TXFB providers
/// so that devs can wrap their widget tests in this widget and not run into the
/// common errors such as uninitialized localization, lack of auth bloc, lack
/// of navigator, etc.
class TfbWidgetTester extends StatelessWidget {
  const TfbWidgetTester({
    required this.child,
    this.mockAuthBloc,
    this.mockNavigator,
    this.mockBiometricsBloc,
    this.mockPolicyScrollCubit,
    this.mockSubmitClaimsBloc,
    this.mockMemberSummaryCubit,
    this.mockCurrentBillDocCubit,
    this.mockRoutingValidationCubit,
    this.mockStatusBarScrollCubit,
    this.mockTabTapNotifier,
    this.mockEnvironment,
    this.mockAppUpdateCubit,
    super.key,
  });

  final Widget child;
  final AuthBloc? mockAuthBloc;
  final TfbNavigator? mockNavigator;
  final BiometricsBloc? mockBiometricsBloc;
  final MockPolicyScrollCubit? mockPolicyScrollCubit;
  final SubmitClaimBloc? mockSubmitClaimsBloc;
  final MemberSummaryCubit? mockMemberSummaryCubit;
  final CurrentBillingDocCubit? mockCurrentBillDocCubit;
  final RoutingValidationCubit? mockRoutingValidationCubit;
  final StatusBarScrollCubit? mockStatusBarScrollCubit;
  final TabTapNotifier? mockTabTapNotifier;
  final TfbEnvironment? mockEnvironment;
  final AppUpdateCubit? mockAppUpdateCubit;

  @override
  Widget build(BuildContext context) {
    final child = MaterialApp(
      locale: const Locale('EN', 'US'),
      theme: ThemeData(
        extensions: const [
          TfbTypography(),
        ],
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: mockAuthBloc ?? MockAuthBloc(),
          ),
          BlocProvider.value(
            value: mockBiometricsBloc ?? MockBiometricsBloc(),
          ),
          BlocProvider.value(
            value: mockPolicyScrollCubit ?? MockPolicyScrollCubit(),
          ),
          BlocProvider.value(
            value: mockSubmitClaimsBloc ?? MockSubmitClaimBloc(),
          ),
          BlocProvider.value(
            value: mockMemberSummaryCubit ?? MockMemberSummaryCubit(),
          ),
          BlocProvider.value(
            value: mockCurrentBillDocCubit ?? MockCurrentBillingDocCubit(),
          ),
          BlocProvider.value(
            value: mockRoutingValidationCubit ?? MockRoutingValidationCubit(),
          ),
          BlocProvider.value(
            value: mockStatusBarScrollCubit ?? MockStatusBarScrollCubit(),
          ),
          BlocProvider.value(
            value: mockAppUpdateCubit ?? MockAppUpdateCubit(),
          ),
          ChangeNotifierProvider.value(
            value: mockTabTapNotifier ?? TabTapNotifier(null),
          ),
        ],
        child: Provider.value(
          value: mockNavigator ?? MockTfbNavigator(),
          child: this.child,
        ),
      ),
    );

    final environmentWrapper = mockEnvironment != null
        ? ChangeNotifierProvider<EnvironmentNotifier>.value(
            value: EnvironmentNotifier(environment: mockEnvironment),
            child: child,
          )
        : child;

    return environmentWrapper;
  }
}
