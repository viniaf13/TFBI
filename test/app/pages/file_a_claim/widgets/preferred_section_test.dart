import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_type_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/preferred_section/preferred_section.dart';

import '../../../../mocks/mock_submit_claim_bloc.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockSubmitClaimBloc submitClaimBloc;
  late TextEditingController preferredContactPhoneFieldController;
  late ValueNotifier<String?> preferredContactType;

  setUp(
    () {
      registerFallbackValue(SubmitClaimInitState());
      submitClaimBloc = MockSubmitClaimBloc();
      when(() => submitClaimBloc.state).thenReturn(
        mockClaimFormInitSuccess,
      );
      preferredContactPhoneFieldController = TextEditingController();
      preferredContactType = ValueNotifier<String?>(null);
    },
  );
  testWidgets(
      'File a claim preferred section should render preferred contact phone number and preferred contact type',
      (tester) async {
    final ValueNotifier<bool> isFormValid = ValueNotifier(true);

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: PreferredSection(
              isFormValid: isFormValid,
              preferredContactPhoneFieldController:
                  preferredContactPhoneFieldController,
              preferredContactType: preferredContactType,
            ),
          ),
        ),
      ),
    );

    expect(
      find.byType(ContactPhoneNumberFormField),
      findsOneWidget,
    );
    expect(
      find.byType(ContactTypeBottomSheet),
      findsOneWidget,
    );
  });
}
