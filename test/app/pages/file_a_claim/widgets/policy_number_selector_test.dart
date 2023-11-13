import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/environment/environment_notifier.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/policy_number_selector.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment_dev.dart';
import 'package:txfb_insurance_flutter/shared/widgets/validating_form_field.dart';

import '../../../../mocks/mock_environment_notifier.dart';
import '../../../../mocks/mock_submit_claim_bloc.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockSubmitClaimBloc submitClaimBloc;
  late MockEnvironmentNotifier mockEnvironmentNotifier;

  setUp(() {
    submitClaimBloc = MockSubmitClaimBloc();
    mockEnvironmentNotifier = MockEnvironmentNotifier();

    registerFallbackValue(SubmitClaimInitState());

    when(() => submitClaimBloc.state).thenReturn(
      mockClaimFormInitSuccess,
    );
    when(() => mockEnvironmentNotifier.environment).thenReturn(
      TfbEnvironmentDev(),
    );
  });

  testWidgets('PolicyNumberSelector should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: Scaffold(
          body: ChangeNotifierProvider<EnvironmentNotifier>(
            create: (context) => mockEnvironmentNotifier,
            child: BlocProvider<SubmitClaimBloc>.value(
              value: submitClaimBloc,
              child: PolicyNumberSelector(
                onPolicySelected: (policy) {},
                selectedValueController: TextEditingController(),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byType(ValidatingFormField),
      findsOneWidget,
    );

    expect(
      find.text(AppLocalizationsEn().policyNumLabel),
      findsOneWidget,
    );

    await tester.tap(
      find.byType(ValidatingFormField),
    );
    expect(
      find.text(AppLocalizationsEn().policyNumLabel),
      findsOneWidget,
    );

    expect(
      find.text(AppLocalizationsEn().policyNumLabel),
      findsOneWidget,
    );
  });
}
