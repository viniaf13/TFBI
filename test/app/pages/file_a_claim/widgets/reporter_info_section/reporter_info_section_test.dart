import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_phone_number_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/generic_fields/contact_type_bottom_sheet.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/bottom_sheet_reporter_type.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/email_address_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/name_form_field.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/reporter_info_section/reporter_info_section.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/shared/submit_claim_reporter_info.dart';

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
      'reporter info section should render name, reporter type, phone number, contact type and email adrress fields',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider<SubmitClaimBloc>.value(
          value: submitClaimBloc,
          child: Scaffold(
            body: ReporterInfoSection(
              isFormValid: ValueNotifier<bool>(true),
              insuredName: 'John Doe',
              reporterInfoNotifier: ValueNotifier<ReporterInformation>(
                const ReporterInformation(),
              ),
            ),
          ),
        ),
      ),
    );

    expect(
      find.text(
        AppLocalizationsEn().reporterInformationTitle,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(
        NameFormField,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(
        BottomSheetReporterType,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(
        ContactPhoneNumberFormField,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(
        ContactTypeBottomSheet,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(
        EmailAddressFormField,
      ),
      findsOneWidget,
    );
  });
}
