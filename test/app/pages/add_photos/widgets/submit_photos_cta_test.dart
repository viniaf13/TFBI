import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/widgets/submit_photos_cta.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import '../../../../mocks/mock_submit_claim_bloc.dart';
import '../../../../mocks/models/auto_claim.dart';
import '../../../../mocks/models/property_claim.dart';
import '../../../../widgets/tfb_widget_tester.dart';

void main() {
  MockSubmitClaimBloc submitClaimBloc = MockSubmitClaimBloc();

  setUp(() {
    registerFallbackValue(
      SubmitPropertyClaimEvent(
        propertyClaimSubmission: MockPropertyClaim.getPropertyClaim(),
      ),
    );
    registerFallbackValue(
      SubmitAutoClaimEvent(
        autoClaimSubmission: MockAutoClaim.getAutoClaim(),
      ),
    );
    submitClaimBloc = MockSubmitClaimBloc();
  });

  testWidgets('Should show right message when there are no photos selected',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: SubmitPhotosCta(
          photos: const [],
          policyType: PolicyType.homeowners,
          userAccessToken: 'userAccessToken',
          apiUrl: 'apiUrl',
          claim: ClaimSubmission(
            policyType: PolicyType.homeowners,
            claimFormAnswers: MockPropertyClaim.getPropertyClaim(),
            policySelection: MockPropertyClaim.getPropertyPolicySelection(),
            dateOfLoss: '01/01/2023',
          ),
        ),
      ),
    );
    expect(
      find.text(AppLocalizationsEn().submitClaimWithoutPhotos),
      findsOneWidget,
    );
    expect(
      find.text(AppLocalizationsEn().submitClaimAndPhotos),
      findsNothing,
    );
  });

  testWidgets('Should show right message when there are photos selected',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        child: SubmitPhotosCta(
          photos: [
            XFile('.'),
          ],
          policyType: PolicyType.homeowners,
          userAccessToken: 'userAccessToken',
          apiUrl: 'apiUrl',
          claim: ClaimSubmission(
            policyType: PolicyType.homeowners,
            claimFormAnswers: MockPropertyClaim.getPropertyClaim(),
            policySelection: MockPropertyClaim.getPropertyPolicySelection(),
            dateOfLoss: '01/01/2023',
          ),
        ),
      ),
    );
    expect(
      find.text(AppLocalizationsEn().submitClaimWithoutPhotos),
      findsNothing,
    );
    expect(
      find.text(AppLocalizationsEn().submitClaimAndPhotos),
      findsOneWidget,
    );
  });

  testWidgets(
      'On press with claim type property, should submit form data to property API',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockSubmitClaimsBloc: submitClaimBloc,
        child: SubmitPhotosCta(
          photos: const [],
          policyType: PolicyType.homeowners,
          userAccessToken: 'userAccessToken',
          apiUrl: 'apiUrl',
          claim: ClaimSubmission(
            policyType: PolicyType.homeowners,
            claimFormAnswers: MockPropertyClaim.getPropertyClaim(),
            policySelection: MockPropertyClaim.getPropertyPolicySelection(),
            dateOfLoss: '01/01/2023',
          ),
        ),
      ),
    );
    await tester.tap(find.byType(TfbFilledButton));
    verify(() => submitClaimBloc.add(any<SubmitPropertyClaimEvent>()))
        .called(1);
  });

  testWidgets(
      'On press with claim type auto, should submit form data to auto API',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockSubmitClaimsBloc: submitClaimBloc,
        child: SubmitPhotosCta(
          photos: const [],
          policyType: PolicyType.txPersonalAuto,
          userAccessToken: 'userAccessToken',
          apiUrl: 'apiUrl',
          claim: ClaimSubmission(
            policyType: PolicyType.txPersonalAuto,
            claimFormAnswers: MockAutoClaim.getAutoClaim(),
            policySelection: MockAutoClaim.getAutoPolicySelection(),
            dateOfLoss: '01/01/2023',
          ),
        ),
      ),
    );
    await tester.tap(find.byType(TfbFilledButton));
    verify(() => submitClaimBloc.add(any<SubmitAutoClaimEvent>())).called(1);
  });
}
