import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/loss_and_damage_section.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_loss_info.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_submit_claim_bloc.dart';
import '../../../../../widgets/tfb_widget_tester.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

void main() {
  late MockSubmitClaimBloc submitClaimBloc;

  setUp(
    () {
      registerFallbackValue(SubmitClaimInitState());
      submitClaimBloc = MockSubmitClaimBloc();
      when(() => submitClaimBloc.state).thenReturn(
        mockClaimFormInitSuccess,
      );
    },
  );

  testWidgets('LossAndDamageSection should render title and given date',
      (tester) async {
    const String dateOfLoss = '05/23/2023';
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: SingleChildScrollView(
              child: LossAndDamageSection(
                dateOfLoss: dateOfLoss,
                isFormValid: ValueNotifier<bool>(true),
                lossInfoNotifier: ValueNotifier<LossInformation>(
                  const LossInformation(),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(
        AppLocalizationsEn().lossAndDamageInformationTitle,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().lossAndDamageInformationSubtitle(dateOfLoss),
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().additionalDescLossLabel,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().typeOfLossLabel,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().timeOfLossTextFormField,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().cityFormField,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().state,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().policeCaseNumberFormField,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().policeDepartmentFormField,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().locationTextFormField,
      ),
      findsOneWidget,
    );
  });
}
