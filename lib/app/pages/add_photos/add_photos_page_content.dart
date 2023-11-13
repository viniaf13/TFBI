import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/analytics/events/submit_claim.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/workmanager/import_photo_workmanager.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/domain/exceptions/save_image_exception.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_auto_success.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_homeowner_success.dart';
import 'package:txfb_insurance_flutter/domain/repositories/submit_photo_repository.dart';
import 'package:txfb_insurance_flutter/shared/widgets/icon_text_row.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/widgets/photos_description_list_auto.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/widgets/photos_description_list_homeowner.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/widgets/submit_photos_cta.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_image_picker.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/widgets/photo_carousel/photo_carousel.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/foundation.dart';

const kMaxPhotosAllowed = 10;

class AddPhotosPageContent extends StatefulWidget {
  const AddPhotosPageContent({
    required this.claim,
    required this.userAccessToken,
    required this.apiUrl,
    super.key,
  });
  final ClaimSubmission claim;
  final String userAccessToken;
  final String apiUrl;

  @override
  State<AddPhotosPageContent> createState() => _AddPhotosPageContentState();
}

class _AddPhotosPageContentState extends State<AddPhotosPageContent> {
  late List<XFile> photos;
  late bool hasCameraOrMicPermanentlyDenied = false;

  OverlayEntry overlay = OverlayEntry(
    builder: (context) => const TfbLoadingOverlay(),
  );

  Future<void> checkPermissions() async {
    final cameraPermissionStatus =
        await CameraImagePicker.checkCameraPermissions();
    final microphonePermissionStatus =
        await CameraImagePicker.checkMicrophonePermissions();
    setState(() {
      hasCameraOrMicPermanentlyDenied =
          cameraPermissionStatus.isPermanentlyDenied ||
              microphonePermissionStatus.isPermanentlyDenied;
    });
  }

  @override
  void initState() {
    TfbAnalytics.instance.track(
      const AddPhotosClaimFormViewEvent(),
    );
    super.initState();
    checkPermissions();
    photos = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubmitClaimBloc, SubmitClaimState>(
      listener: (context, state) {
        if (!overlay.mounted &&
            (state is SubmitAutoClaimProcessingState ||
                state is SubmitPropertyClaimProcessingState)) {
          showLoaderDialog(context);
        }
        if (state is SubmitPropertyClaimSuccessState ||
            state is SubmitAutoClaimSuccessState) {
          TfbAnalytics.instance.track(
            SubmitClaim(
              policyType: widget.claim.policySelection.policyType.name(context),
              policyNumber: widget.claim.policySelection.policyNumber,
              dateOfLoss: widget.claim.dateOfLoss,
              timeOfLoss:
                  widget.claim.claimFormAnswers.lossInformation?.timeOfLoss ??
                      '',
              screenName: context.screenName,
            ),
          );
        }
        if (state is SubmitPropertyClaimSuccessState) {
          startPhotosUpload(
            state.data.referenceNumber,
            widget.claim.policyType,
            widget.userAccessToken,
            widget.apiUrl,
            context,
          ).then((_) {
            overlay.remove();
            context.navigator.pushFileAClaimHomeOwnerSuccessPage(
              PolicyHomeownerSuccess(
                confirmationNumber: state.data.referenceNumber,
                policySelection: widget.claim.policySelection,
                dateOfLoss: widget.claim.dateOfLoss,
              ),
            );
          });
        }
        if (state is SubmitAutoClaimSuccessState) {
          startPhotosUpload(
            state.data.claimNumber!,
            widget.claim.policyType,
            widget.userAccessToken,
            widget.apiUrl,
            context,
          ).then(
            (_) {
              overlay.remove();
              context.navigator.pushFileAClaimPersonalAutoSuccessPage(
                PolicyAutoSuccess(
                  claimNumber: state.data.claimNumber!,
                  policySelection: widget.claim.policySelection,
                  dateOfLoss: widget.claim.dateOfLoss,
                ),
              );
            },
          );
        }

        if (state is SubmitPropertyClaimFailureState ||
            state is SubmitAutoClaimFailureState) {
          overlay.remove();
          context.showErrorSnackBar(
            text: context.getLocalizationOf.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: TfbAnimatedAppBar(
            titleString: context.getLocalizationOf.addPhotosTitle,
            automaticallyImplyLeading: false,
          ),
          body: TfbDropShadowScrollWidget(
            showFooterShadow: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: kSpacingMedium),
                      child: Text(
                        context.getLocalizationOf.addPhotosTitle,
                        style: context.tfbText.header3.copyWith(
                          color: TfbBrandColors.blueHighest,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: kSpacingMedium),
                      child: Text(
                        context.getLocalizationOf.addPhotosDescription,
                        style: context.tfbText.bodyRegularSmall.copyWith(
                          color: TfbBrandColors.grayHighest,
                        ),
                      ),
                    ),
                    IconTextRow(
                      imageAssetString: TfbAssetStrings.cameraIcon,
                      rowPadding: const EdgeInsets.symmetric(),
                      textPadding: const EdgeInsets.only(left: kSpacingSmall),
                      childWidget: GestureDetector(
                        onTap: () {
                          if (!hasCameraOrMicPermanentlyDenied &&
                              photos.length < kMaxPhotosAllowed) {
                            CameraImagePicker.askForCameraPermissions()
                                .then((permissionGranted) {
                              if (permissionGranted) {
                                CameraImagePicker.takeNewPhoto().then((photo) {
                                  addPhotoToState(photo, context);
                                  setState(() {});
                                });
                              } else {
                                setState(() {
                                  hasCameraOrMicPermanentlyDenied = true;
                                });
                                context.showErrorSnackBar(
                                  text: context.getLocalizationOf
                                      .accessPermissionsHaveBeenDenied,
                                );
                              }
                            });
                          }
                        },
                        child: Text(
                          context.getLocalizationOf.takePhotoCamera,
                          style: context.tfbText.bodyMediumLarge.copyWith(
                            color: hasCameraOrMicPermanentlyDenied ||
                                    photos.length >= kMaxPhotosAllowed
                                ? TfbBrandColors.grayHigh
                                : TfbBrandColors.blueHigh,
                          ),
                        ),
                      ),
                    ),
                    IconTextRow(
                      imageAssetString: TfbAssetStrings.cameraRollIcon,
                      rowPadding:
                          const EdgeInsets.symmetric(vertical: kSpacingSmall),
                      textPadding: const EdgeInsets.only(left: kSpacingSmall),
                      childWidget: GestureDetector(
                        onTap: () {
                          if (photos.length < kMaxPhotosAllowed) {
                            CameraImagePicker.selectPhotos()
                                .then((selectedPhotos) {
                              addPhotosToStateBulk(selectedPhotos, context);
                              setState(() {});
                            });
                          }
                        },
                        child: Text(
                          context.getLocalizationOf.selectPhotoCameraRoll,
                          style: context.tfbText.bodyMediumLarge.copyWith(
                            color: photos.length >= kMaxPhotosAllowed
                                ? TfbBrandColors.grayHigh
                                : TfbBrandColors.blueHigh,
                          ),
                        ),
                      ),
                    ),
                    const SeparatorLine(),
                    PhotoCarousel(
                      images: photos,
                      onRemove: (photo) {
                        photos.remove(photo);
                        if (photos.length <= kMaxPhotosAllowed) {
                          context.dismissSnackbar();
                        }
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: photos.isEmpty ? kSpacingZero : kSpacingMedium,
                    ),
                    Text(
                      context.getLocalizationOf.includePhotosOf,
                      style: context.tfbText.bodyRegularSmall.copyWith(
                        color: TfbBrandColors.grayHighest,
                      ),
                    ),
                    const SizedBox(
                      height: kSpacingSmall,
                    ),
                    if (widget.claim.policyType == PolicyType.txPersonalAuto)
                      const PhotosDescriptionListAuto(),
                    if (widget.claim.policyType == PolicyType.homeowners)
                      const PhotosDescriptionListHomeowner(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SubmitPhotosCta(
            photos: photos,
            policyType: widget.claim.policyType,
            claim: widget.claim,
            apiUrl: widget.apiUrl,
            userAccessToken: widget.userAccessToken,
          ),
        );
      },
    );
  }

  void showLoaderDialog(BuildContext context) {
    overlay = OverlayEntry(
      builder: (context) => const TfbLoadingOverlay(),
    );

    Overlay.of(context).insert(overlay);
  }

  void addPhotosToStateBulk(List<XFile?> selectedPhotos, BuildContext context) {
    for (final photo in selectedPhotos) {
      if (photo != null &&
          !photos.any(
            (previousPhoto) => previousPhoto.name == photo.name,
          )) {
        photos.add(photo);
      }
    }
    if (photos.length > kMaxPhotosAllowed) {
      context.showProcessingSnackBar(
        duration: const Duration(
          days: 1,
        ),
        text: context.getLocalizationOf.onlyTenPhotosWillBeSubmitted,
      );
    }
  }

  void addPhotoToState(XFile? photo, BuildContext context) {
    if (photo != null) {
      photos.add(photo);
    }
    if (photos.length > kMaxPhotosAllowed) {
      context.showProcessingSnackBar(
        duration: const Duration(
          days: 1,
        ),
        text: context.getLocalizationOf.onlyTenPhotosWillBeSubmitted,
      );
    }
  }

  Future<void> startPhotosUpload(
    String claimId,
    PolicyType policyType,
    String userAccessToken,
    String apiBaseUrl,
    BuildContext context,
  ) async {
    if (photos.isNotEmpty) {
      try {
        await CameraFileStorage.saveImagesToDocumentsDirectoryBulk(
          photos.sublist(
            0,
            photos.length > kMaxPhotosAllowed
                ? kMaxPhotosAllowed
                : photos.length,
          ),
          claimId,
          policyType,
        );
        await startPhotoUploadWorkmanager(
          userAccessToken,
          apiBaseUrl,
        );
      } on InsufficientSpaceException {
        if (context.mounted) {
          context.showErrorSnackBar(
            text: context.getLocalizationOf.noStorageSpaceAvailable,
          );
        }
      }
    }
  }

  Future<void> startPhotoUploadWorkmanager(
    String userAccessToken,
    String apiBaseUrl,
  ) async {
    await writeStorageInformation(userAccessToken, apiBaseUrl);
    if (kDebugMode) {
      await SubmitPhotoRepository().importPhoto();
    } else {
      await Workmanager().registerOneOffTask(
        ksubmitPhotoTask,
        ksubmitPhotoTask,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(
          seconds: 10,
        ),
      );
    }
  }

  Future<void> writeStorageInformation(
    String userAccessToken,
    String apiBaseUrl,
  ) async {
    await const FlutterSecureStorage()
        .write(key: kTfbUserToken, value: userAccessToken);
    await const FlutterSecureStorage()
        .write(key: kApiBaseUrl, value: apiBaseUrl);
  }
}
