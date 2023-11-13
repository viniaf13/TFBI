import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_haven/auth/auth_bloc.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/biometrics/biometrics_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/login/login_page.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/vehicle_card.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/device/biometrics/tfb_biometrics.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_authentication_client.dart';
import 'package:txfb_insurance_flutter/domain/models/auto_policy_document_metadata_repository/tfb_auto_policy_document_metadata.dart';
import 'package:txfb_insurance_flutter/domain/repositories/storage/tfb_user_storage_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

import '../../../mocks/bloc/mock_auth_bloc.dart';
import '../../../mocks/mock_tfb_auto_policy_document_metadata_repository.dart';
import '../../../mocks/mock_tfb_navigator.dart';
import '../../../mocks/page_parameters/mock_pdf_viewer_events_parameters.dart';
import '../../../widgets/tfb_widget_tester.dart';

class MockTfbAuthClient extends Mock implements TfbAuthenticationClient {}

class MockTfbUserStorageRepository extends Mock
    implements TfbUserStorageRepository<TfbUser> {}

void main() {
  setUpAll(() {
    final pdfViewerEventsParameters =
        MockPdfViewerEventsParameters.getEventsParameters();
    registerFallbackValue(
      PdfViewerPageParameters(
        title: 'title',
        filePath: 'filePath',
        pdfViewerEventsParameters: pdfViewerEventsParameters,
      ),
    );
  });

  testWidgets(
      'Tapping on a vehicle insurance card CTA calls the navigator to move to the PDF viewer page',
      (tester) async {
    final TfbNavigator mockNavigator = MockTfbNavigator();
    final AuthBloc mockAuthBloc = MockAuthBloc();
    final TfbUserStorageRepository mockUserStorageRepository =
        MockTfbUserStorageRepository();
    final biometricsBloc = BiometricsBloc(
      biometrics: TfbBiometrics(),
      userStorageRepository: mockUserStorageRepository,
    );
    when(mockUserStorageRepository.getUser).thenAnswer((_) => Future.value());
    when(() => mockAuthBloc.state).thenAnswer((_) => AuthSignedOut());

    await tester.pumpWidget(
      TfbWidgetTester(
        mockAuthBloc: mockAuthBloc,
        mockNavigator: mockNavigator,
        mockBiometricsBloc: biometricsBloc,
        child:
            const SingleValueMockTfbAutoPolicyDocumentMetadataRepositoryProvider(
          child: LoginPage(shouldSkipSplashAnimation: true),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(VehicleCard), findsOneWidget);

    await tester.tap(find.byType(VehicleCard));

    verify(() => mockNavigator.goPdfViewerPage(any())).called(1);
  });
}

/// Provide a single policy document metadata instance to child widgets
class SingleValueMockTfbAutoPolicyDocumentMetadataRepositoryProvider
    extends StatelessWidget {
  const SingleValueMockTfbAutoPolicyDocumentMetadataRepositoryProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TfbAutoPolicyDocumentMetadataRepository documentMetadataRepository =
        MockTfbAutoPolicyDocumentMetadataRepository();
    when(documentMetadataRepository.readAll).thenAnswer(
      (invocation) => Future.value([
        TfbAutoPolicyDocumentMetadata(
          policyNumber: '12345',
          vehicleDisplayTitles: ['2023 Dodge Ram'],
          expirationDate: DateTime.now().add(const Duration(days: 1)),
          documentPath: '/',
          id: 'id',
        ),
      ]),
    );

    return Provider.value(
      value: documentMetadataRepository,
      child: child,
    );
  }
}
