import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/loss_and_damage_section/state_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';

import '../../../../../mocks/mock_submit_claim_bloc.dart';
import '../../../../../widgets/tfb_widget_tester.dart';

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
    'State Bottom Sheet, after selecting the option, should show the same state as selected',
    (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        TfbWidgetTester(
          child: BlocProvider<SubmitClaimBloc>.value(
            value: submitClaimBloc,
            child: Scaffold(
              body: StateBottomSheet(
                onChanged: (_) {},
                selectedValueController: controller,
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();
      final widgetToTap = find.byType(TextButton).first;
      await tester.ensureVisible(widgetToTap);
      await tester.pumpAndSettle();
      await tester.tap(widgetToTap);
      await tester.pumpAndSettle();
      expect(controller.text, 'Texas');
    },
  );
}
