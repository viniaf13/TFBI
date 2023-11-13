import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/registration_resend/registration_resend_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification/widgets/registration_resend_snackbar_listener.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification/widgets/verification_bottom_content.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({
    required this.resendInformation,
    required this.memberAccessClient,
    super.key,
  });

  final RegistrationResendRequest resendInformation;
  final TfbMemberAccessClient memberAccessClient;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationResendCubit(memberAccessClient),
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            ),
            body: BlocBuilder<RegistrationResendCubit, RegistrationResendState>(
              builder: (context, state) {
                return GradientBackground(
                  gradient: LightColors.authenticationBackgroundGradient,
                  child: ScrollableViewWithPinnedButton(
                    button: VerificationBottomContent(
                      registrationRequest: resendInformation,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ListView(
                        children: [
                          const RegistrationResendSnackbarListener(),
                          Text(
                            context.getLocalizationOf.verifyEmailPageTitle,
                            style: context.tfbText.header3.copyWith(
                              color: TfbBrandColors.blueHighest,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: kSpacingMedium),
                            child: Text(
                              context.getLocalizationOf.checkEmailVerify,
                              style: context.tfbText.bodyRegularLarge,
                            ),
                          ),
                          Container(
                            // TFBI-459: Replace with dynamic spacing
                            margin: const EdgeInsets.symmetric(
                              vertical: kSpacingExtraLarge * 3,
                            ),
                            height: 165,
                            child: Image.asset(TfbAssetStrings.paperPlane),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
