import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/shared/widgets/icon_text_row.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/add_photos_page_content.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/photo_carousel/photo_carousel.dart';

import '../../../mocks/bloc/mock_status_bar_scroll_cubit.dart';
import '../../../mocks/mock_submit_claim_bloc.dart';
import '../../../mocks/models/auto_claim.dart';
import '../../../mocks/models/property_claim.dart';
import '../../../widgets/tfb_widget_tester.dart';

void main() {
  late MockSubmitClaimBloc submitClaimBloc;
  final mockStatusBarScrollCubit = MockStatusBarScrollCubit();

  final propertyClaimSubmissionMock = ClaimSubmission(
    policyType: PolicyType.homeowners,
    claimFormAnswers: MockPropertyClaim.getPropertyClaim(),
    policySelection: MockPropertyClaim.getPropertyPolicySelection(),
    dateOfLoss: '01/01/2023',
  );

  final autoClaimSubmissionMock = ClaimSubmission(
    policyType: PolicyType.txPersonalAuto,
    claimFormAnswers: MockAutoClaim.getAutoClaim(),
    policySelection: MockAutoClaim.getAutoPolicySelection(),
    dateOfLoss: '01/01/2023',
  );

  setUp(() {
    submitClaimBloc = MockSubmitClaimBloc();
    when(() => submitClaimBloc.state).thenReturn(
      mockClaimFormInitSuccess,
    );
    when(() => mockStatusBarScrollCubit.state)
        .thenReturn(const StatusBarScrollInitial(''));
  });

  testWidgets(
      'Add Photos page should render title, copy, two clickable texts with icon and specific description for Auto claims',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockSubmitClaimsBloc: submitClaimBloc,
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: AddPhotosPageContent(
          claim: autoClaimSubmissionMock,
          apiUrl: '',
          userAccessToken: '',
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text(
        AppLocalizationsEn().addPhotosTitle,
      ),
      findsNWidgets(2),
    );
    expect(
      find.text(
        AppLocalizationsEn().addPhotosDescription,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(IconTextRow),
      findsNWidgets(2),
    );
    expect(
      find.byType(PhotoCarousel),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().includePhotosOf,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().frontVehiclePlate,
        skipOffstage: false,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().vehicleIdNumber,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().anyDamages,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(TfbFilledButton),
      findsOneWidget,
    );
  });

  testWidgets(
      'Add Photos page should render title, copy, two clickable texts with icon and specific description for Property claims',
      (tester) async {
    await tester.pumpWidget(
      TfbWidgetTester(
        mockSubmitClaimsBloc: submitClaimBloc,
        mockStatusBarScrollCubit: mockStatusBarScrollCubit,
        child: BlocProvider.value(
          value: submitClaimBloc,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text(
        AppLocalizationsEn().addPhotosTitle,
      ),
      findsNWidgets(2),
    );
    expect(
      find.text(
        AppLocalizationsEn().addPhotosDescription,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(IconTextRow),
      findsNWidgets(2),
    );
    expect(
      find.byType(PhotoCarousel),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().includePhotosOf,
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        AppLocalizationsEn().occurrenceOverviewProperty,
      ),
      findsOneWidget,
    );
    expect(
      find.byType(TfbFilledButton),
      findsOneWidget,
    );
  });
  group('Tests of checkPermission', () {
    // Boolean that represents the denial of camera access.
    var hasPermission = true;
    var pickImageWasCalled = false;
    void mockCameraPermission({required PermissionStatus status}) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (methodCall) async {
        if (methodCall.method == 'openAppSettings') {
          return true;
        }
        if (methodCall.method == 'checkPermissionStatus') {
          hasPermission = false;
          return status.index;
        }
        if (methodCall.method == 'requestPermissions') {
          final Map<dynamic, dynamic> map = {};
          for (final item in Permission.values) {
            map[item.value] = PermissionStatus.granted.index;
          }
          hasPermission = true;
          return map;
        }
        return null;
      });
    }

    void mockImagePicker() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('plugins.flutter.io/image_picker'),
              (methodCall) async {
        if (methodCall.method == 'pickMultiImage') {
          pickImageWasCalled = true;
          return [];
        }
        if (methodCall.method == 'pickImage') {
          pickImageWasCalled = true;
          return '.';
        }

        return null;
      });
    }

    setUp(() async {
      hasPermission = false;
      pickImageWasCalled = false;
      mockImagePicker();
    });

    testWidgets(
        'Test to check if camera access is denied and, after requesting permission by clicking the camera button, camera access is granted.',
        (tester) async {
      mockCameraPermission(status: PermissionStatus.denied);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(hasPermission, isFalse);
      await tester.tap(find.byType(IconTextRow).first);
      expect(hasPermission, isTrue);
      expect(pickImageWasCalled, isTrue);
    });

    testWidgets(
        'Test to verify if the camera access request is permanently denied, even after clicking the camera button',
        (tester) async {
      mockCameraPermission(status: PermissionStatus.permanentlyDenied);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(hasPermission, isFalse);
      await tester.tap(find.byType(IconTextRow).first);
      expect(hasPermission, isFalse);
      expect(pickImageWasCalled, isFalse);
    });

    testWidgets(
        'Test to check if camera access is denied and, after requesting permission by clicking the gallery button, camera access is granted.',
        (tester) async {
      mockCameraPermission(status: PermissionStatus.denied);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(hasPermission, isFalse);
      await tester.tap(find.byType(IconTextRow).last);
      expect(pickImageWasCalled, isTrue);
    });

    testWidgets(
        'Test to verify if the camera access request is permanently denied, even after clicking the gallery button',
        (tester) async {
      mockCameraPermission(status: PermissionStatus.permanentlyDenied);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(hasPermission, isFalse);
      await tester.tap(find.byType(IconTextRow).last);
      expect(pickImageWasCalled, isTrue);
    });
  });

  group('Snack bar tests', () {
    void mockImagePicker({
      List<String> pickMultiImage = const [],
      String pickImage = '.',
    }) {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('plugins.flutter.io/image_picker'),
              (methodCall) async {
        if (methodCall.method == 'pickMultiImage') {
          return pickMultiImage;
        }
        if (methodCall.method == 'pickImage') {
          return pickImage;
        }

        return null;
      });
    }

    void mockCameraPermission() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('flutter.baseflow.com/permissions/methods'),
              (methodCall) async {
        if (methodCall.method == 'openAppSettings') {
          return true;
        }
        if (methodCall.method == 'checkPermissionStatus') {
          return PermissionStatus.granted.index;
        }
        if (methodCall.method == 'requestPermissions') {
          final Map<dynamic, dynamic> map = {};
          for (final item in Permission.values) {
            map[item.value] = PermissionStatus.granted.index;
          }
          return map;
        }
        return null;
      });
    }

    final galleryPhotos = <String>[];
    setUp(() {
      mockCameraPermission();
      galleryPhotos.clear();
    });

    testWidgets(
        'Test if the user adds more than 10 photos, the snack bar appears',
        (tester) async {
      const kNumberOfPhotosAdded = 11;
      for (var i = 0; i < kNumberOfPhotosAdded; i++) {
        galleryPhotos.add('photo-$i');
      }
      mockImagePicker(pickMultiImage: galleryPhotos);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconTextRow).last);
      await tester.pumpAndSettle();
      expect(
        find.text(
          AppLocalizationsEn().onlyTenPhotosWillBeSubmitted,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        "Test if the user adds until than 10 photos, the snack bar doesn't appear",
        (tester) async {
      const kNumberOfPhotosAdded = 10;
      for (var i = 0; i < kNumberOfPhotosAdded; i++) {
        galleryPhotos.add('photo-$i');
      }
      mockImagePicker(pickMultiImage: galleryPhotos);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconTextRow).last);
      await tester.pumpAndSettle();

      expect(
        find.text(
          AppLocalizationsEn().onlyTenPhotosWillBeSubmitted,
        ),
        findsNothing,
      );
    });

    testWidgets(
        'Test if the user adds more than 10 photos, the snack bar appears, and after clicking the delete button, the snack bar disappears',
        (tester) async {
      const kNumberOfPhotosAdded = 11;
      for (var i = 0; i < kNumberOfPhotosAdded; i++) {
        galleryPhotos.add('photo-$i');
      }
      mockImagePicker(pickMultiImage: galleryPhotos);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconTextRow).last);
      await tester.pumpAndSettle();
      expect(
        find.text(
          AppLocalizationsEn().onlyTenPhotosWillBeSubmitted,
        ),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      final photoCarouselType = find.byType(PhotoCarousel);
      final buttomFinder = find.descendant(
        of: photoCarouselType.first,
        matching: find.byWidgetPredicate((widget) => widget is InkWell),
      );
      await tester.tap(buttomFinder.first);
      await tester.pumpAndSettle();
      expect(
        find.text(
          AppLocalizationsEn().onlyTenPhotosWillBeSubmitted,
        ),
        findsNothing,
      );
    });

    testWidgets(
        'Test if the user adds more than 11 photos, the snack bar appears, and after clicking the delete button, the snack bar continue appearing',
        (tester) async {
      const kNumberOfPhotosAdded = 12;
      for (var i = 0; i < kNumberOfPhotosAdded; i++) {
        galleryPhotos.add('photo-$i');
      }
      mockImagePicker(pickMultiImage: galleryPhotos);
      await tester.pumpWidget(
        TfbWidgetTester(
          mockSubmitClaimsBloc: submitClaimBloc,
          mockStatusBarScrollCubit: mockStatusBarScrollCubit,
          child: AddPhotosPageContent(
            claim: propertyClaimSubmissionMock,
            apiUrl: '',
            userAccessToken: '',
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconTextRow).last);
      await tester.pumpAndSettle();
      expect(
        find.text(
          AppLocalizationsEn().onlyTenPhotosWillBeSubmitted,
        ),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      final photoCarouselType = find.byType(PhotoCarousel);
      final bottomFinder = find.descendant(
        of: photoCarouselType.first,
        matching: find.byWidgetPredicate((widget) => widget is InkWell),
      );
      await tester.tap(bottomFinder.first);
      await tester.pumpAndSettle();
      expect(
        find.text(
          AppLocalizationsEn().onlyTenPhotosWillBeSubmitted,
        ),
        findsOneWidget,
      );
    });
  });
}
