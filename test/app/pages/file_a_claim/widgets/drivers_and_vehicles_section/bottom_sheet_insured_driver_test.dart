import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/drivers_and_vehicles_section/bottom_sheet_insured_driver.dart';
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

  testWidgets(
    'should show error message when closed without picking an option',
    (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: Scaffold(
              body: InsuredDriversBottomSheet(
                onChanged: (_) {},
                selectedValueController: controller,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InsuredDriversBottomSheet));
      await tester.pumpAndSettle();
      final widgetToTap = find.byType(IconButton);
      await tester.ensureVisible(widgetToTap);
      await tester.pumpAndSettle();
      await tester.tap(widgetToTap);
      await tester.pumpAndSettle();

      expect(
        find.text(
          AppLocalizationsEn().selectedFieldValidation(
            AppLocalizationsEn().insuredDriverFieldLabel.toLowerCase(),
          ),
        ),
        findsOneWidget,
      );
    },
  );
}
