import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/policy_number_selector.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_image_picker.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_info.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/text_with_phone.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_date_picker_input.dart';

class FileAClaimSection extends StatefulWidget {
  const FileAClaimSection({super.key});

  @override
  State<FileAClaimSection> createState() => _FileAClaimSectionState();
}

class _FileAClaimSectionState extends State<FileAClaimSection> {
  bool isButtonActive = false;
  TextEditingController dateInputController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  late bool cameraPermissionsPermanentlyDenied;
  late bool galleryPermissionsPermanentlyDenied;
  final mixpanelTimeZone = tz.getLocation('America/Los_Angeles');
  PolicySelection? selectedPolicy;

  @override
  void initState() {
    dateInputController
      ..text = ''
      ..addListener(enableButtonIfInputIsValid);
    checkPermissions();
    super.initState();
  }

  Future<void> checkPermissions() async {
    final galleryPermissionsStatus =
        await CameraImagePicker.checkGalleryPermissions();
    final cameraPermissionStatus =
        await CameraImagePicker.checkCameraPermissions();
    final microphonePermissionStatus =
        await CameraImagePicker.checkMicrophonePermissions();

    setState(() {
      cameraPermissionsPermanentlyDenied =
          cameraPermissionStatus == PermissionStatus.permanentlyDenied ||
              microphonePermissionStatus == PermissionStatus.permanentlyDenied;
      galleryPermissionsPermanentlyDenied =
          galleryPermissionsStatus == PermissionStatus.permanentlyDenied;
    });
  }

  void enableButtonIfInputIsValid() {
    if (dateInputController.text != '' && selectedPolicy != null) {
      setState(() {
        isButtonActive = true;
      });
    }
  }

  Future<void> showSettingsModal(BuildContext context) async {
    if (cameraPermissionsPermanentlyDenied &&
        galleryPermissionsPermanentlyDenied) {
      await context.navigator.pushGoToSettingsDialog();
    }
  }

  @override
  void dispose() {
    dateInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.only(
          left: kSpacingMedium,
          top: kSpacingMedium,
          right: kSpacingMedium,
        ),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                context.getLocalizationOf.claimsFileAClaimCardTitle,
                style: context.tfbText.header3.copyWith(
                  color: TfbBrandColors.blueHighest,
                ),
              ),
            ),
            const SeparatorLine(),
            Container(
              margin: const EdgeInsets.only(bottom: kSpacingLarge),
              child: Semantics(
                label: context.getLocalizationOf.claimsReportingPhoneNumber,
                child: TextWithPhone(
                  prePhoneNumberString:
                      context.getLocalizationOf.claimsFileAClaimCardTextBegin,
                  phoneNumberForDisplay: kHourClaimsReportingCenterPhoneNumber,
                  phoneNumberForDialing:
                      kHourClaimsReportingCenterPhoneNumberForDialing,
                  postPhoneNumberString:
                      context.getLocalizationOf.claimsFileAClaimCardTextEnd,
                  styleForPhoneNumber: context.tfbText.bodyMediumSmall
                      .copyWith(color: TfbBrandColors.blueHigh),
                  styleForBodyText: context.tfbText.bodyRegularSmall
                      .copyWith(color: TfbBrandColors.grayHighest),
                ),
              ),
            ),
            PolicyNumberSelector(
              onPolicySelected: (PolicySelection? policy) {
                selectedPolicy = policy;
                enableButtonIfInputIsValid();
              },
              selectedValueController: policyNumberController,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: kSpacingLarge),
              child: TfbDatePickerInput(
                controller: dateInputController,
                inputLabel:
                    context.getLocalizationOf.fileAClaimDatePickerInputLabel,
              ),
            ),
            TfbFilledButton(
              onPressed: isButtonActive
                  ? () {
                      showSettingsModal(context).then(
                        (_) {
                          final dateTime = DateFormat('MM/dd/yyyy')
                              .parse(dateInputController.text);
                          final date = tz.TZDateTime(
                            mixpanelTimeZone,
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                          ).toIso8601String();
                          TfbAnalytics.instance.track(
                            BeginClaimEvent(
                              policyType:
                                  selectedPolicy!.policyType.name(context),
                              policyNumber: selectedPolicy!.policyNumber,
                              dateOfLoss: date,
                              screenName: context.screenName,
                            ),
                          );
                          switch (selectedPolicy?.policyType) {
                            case PolicyType.txPersonalAuto:
                              context.navigator.goToFileAnAutoClaimPage(
                                PolicyInfo(
                                  policySelection: selectedPolicy!,
                                  dateOfLoss: dateInputController.text,
                                ),
                              );
                              break;
                            case PolicyType.homeowners:
                              context.navigator.goToFileAClaimHomeOwnerPage(
                                PolicyInfo(
                                  policySelection: selectedPolicy!,
                                  dateOfLoss: dateInputController.text,
                                ),
                              );
                              break;
                            default:
                              context.showErrorSnackBar(
                                text:
                                    'A form for the selected policy type has not been implemmented',
                              );
                          }
                        },
                      );
                    }
                  : null,
              backgroundColor: TfbBrandColors.blueHighest,
              child: Center(
                child: Text(
                  context.getLocalizationOf.claimsBeginClaimCTA,
                  style: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kSpacingMedium,
            ),
          ],
        ),
      ),
    );
  }
}
