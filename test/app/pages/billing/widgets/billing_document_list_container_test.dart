import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_list/billing_document_list_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_document_list/billing_document_list_container.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

import '../../../../widgets/tfb_widget_tester.dart';
import '../../../cubits/billing_document_list/billing_document_list_cubit.dart';

class MockPolicySummary extends Mock implements PolicySummary {}

void main() {
  testWidgets(
      'When the billing document list cubit is processing, it shows a loading icon',
      (tester) async {
    final BillingDocumentListCubit billingDocumentListCubit =
        MockBillingDocumentListCubit();

    when(() => billingDocumentListCubit.state).thenReturn(
      const TfbSingleRequestProcessing(),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: billingDocumentListCubit,
          child: BillingDocumentListContainer(
            policy: MockPolicySummary(),
          ),
        ),
      ),
    );

    expect(find.byType(TfbBrandLoadingIcon), findsOneWidget);
  });

  testWidgets('When the billing document list cubit fails, show the error text',
      (tester) async {
    final BillingDocumentListCubit billingDocumentListCubit =
        MockBillingDocumentListCubit();

    when(() => billingDocumentListCubit.state).thenReturn(
      TfbSingleRequestFailed(error: TfbRequestError()),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: billingDocumentListCubit,
          child: BillingDocumentListContainer(
            policy: MockPolicySummary(),
          ),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().billingDocumentsLoadError),
      findsOneWidget,
    );
  });

  testWidgets(
      'When the billing document list cubit is successful but the results are empty, show the empty state',
      (tester) async {
    final BillingDocumentListCubit billingDocumentListCubit =
        MockBillingDocumentListCubit();

    when(() => billingDocumentListCubit.state).thenReturn(
      const TfbSingleRequestSuccess(response: <BillingListMetadata>[]),
    );

    await tester.pumpWidget(
      TfbWidgetTester(
        child: BlocProvider.value(
          value: billingDocumentListCubit,
          child: BillingDocumentListContainer(
            policy: MockPolicySummary(),
          ),
        ),
      ),
    );

    expect(
      find.text(AppLocalizationsEn().emptyBillingDocuments),
      findsOneWidget,
    );
  });
}
