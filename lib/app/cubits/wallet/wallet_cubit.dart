import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/auto_policy_detail.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  Future<void> handleAddWallet(AutoPolicyDetail policyDetails) async {
    try {
      emit(WalletProcessing());
      final String policyOwner = policyDetails.namedInsuredOne ??
          (policyDetails.namedInsuredTwo ?? '');
      final String yearMakeModel = policyDetails.vehicles.isNotEmpty
          ? policyDetails.vehicles[0].yearMakeModel
          : '';

      final Map<String, dynamic> androidConfig = {
        kGoogleWalletTitleKey: kGoogleWalletTitleValue,
        kGoogleWalletBackgroundColorKey: kGoogleWalletBackgroundColorValue,
        kGoogleWalletSubheaderKey: kGoogleWalletSubheaderValue,
        kGoogleWalletHeaderKey: policyOwner,
        kGoogleWalletField0HeaderKey: kGoogleWalletField0HeaderValue,
        kGoogleWalletField0BodyKey: kGoogleWalletField0BodyValue,
        kGoogleWalletField1HeaderKey: kGoogleWalletField1HeaderValue,
        kGoogleWalletField1BodyKey: policyDetails.expirationDate,
        kGoogleWalletField2HeaderKey: kGoogleWalletField2HeaderValue,
        kGoogleWalletField2BodyKey: policyDetails.policyNumber,
        kGoogleWalletField3HeaderKey: kGoogleWalletField3HeaderValue,
        kGoogleWalletField3BodyKey: yearMakeModel,
      };

      final Map<String, dynamic> iosConfig = {
        kAppleWalletOrganizationNameKey: kAppleWalletOrganizationNameValue,
        kAppleWalletDescriptionKey: kAppleWalletDescriptionValue,
        kAppleWalletLogoTextKey: kAppleWalletLogoTextValue,
        kAppleWalletForegroundColorKey: kAppleWalletForegroundColorValue,
        kAppleWalletBackgroundColorKey: kAppleWalletBackgroundColorValue,
        kAppleWalletPrimaryFieldKey: policyOwner,
        kAppleWalletSecondaryField0LabelKey:
            kAppleWalletSecondaryField0LabelValue,
        kAppleWalletSecondaryField0BodyKey:
            kAppleWalletSecondaryField0BodyValue,
        kAppleWalletSecondaryField1LabelKey:
            kAppleWalletSecondaryField1LabelValue,
        kAppleWalletSecondaryField1BodyKey: policyDetails.expirationDate,
        kAppleWalletAuxiliaryField0LabelKey:
            kAppleWalletAuxiliaryField0LabelValue,
        kAppleWalletAuxiliaryField0BodyKey: policyDetails.policyNumber,
        kAppleWalletAuxiliaryField1LabelKey:
            kAppleWalletAuxiliaryField1LabelValue,
        kAppleWalletAuxiliaryField1BodyKey: yearMakeModel,
      };

      final String passId =
          await WalletCardPlatform.instance.createPassFromTemplate(
        jsonTemplatePath: Platform.isIOS
            ? TfbAssetStrings.walletIosPath
            : TfbAssetStrings.walletAndroidPath,
        templateValues: Platform.isIOS ? iosConfig : androidConfig,
      );

      if (passId.isEmpty) {
        throw Exception('Could not add Insurance Card to Wallet');
      }

      TfbLogger.verbose('Add insurance card to wallet result: "$passId"');
      emit(const WalletSuccess());
    } catch (e, stack) {
      final error = TfbRequestError.fromObject(e, stack: stack);
      TfbLogger.exception(
        'Could not add Insurance Card to Wallet',
        error,
        stack,
      );
      emit(WalletFailure(error));
    }
  }
}
