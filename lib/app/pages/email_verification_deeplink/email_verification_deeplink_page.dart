import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/email_verification/email_verification_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_login/update_login_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/email_verification_deeplink/widgets/maybe_update_email_listener.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_never_pop.dart';

class EmailVerificationDeeplinkPage extends StatelessWidget {
  const EmailVerificationDeeplinkPage({
    required this.verificationCode,
    super.key,
  });

  final String? verificationCode;

  @override
  Widget build(BuildContext context) {
    if (verificationCode != null) {
      (() async {
        // Wait for the screen transition to complete before kicking off the request
        // Sometimes it can complete too quickly and cause an odd transition.
        const screenTransitionDuration = Duration(milliseconds: 300);
        await Future<void>.delayed(screenTransitionDuration);

        if (context.mounted) {
          context.read<EmailVerificationCubit>().verifyEmail(verificationCode!);
        }
      })();
    }

    final authState = BlocProvider.of<AuthBloc>(context).state;

    return TfbNeverPop(
      child: Scaffold(
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
        body: MaybeUpdateEmailListener(
          child: BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
            listener: (context, state) async {
              if (authState is AuthSignedIn &&
                  state is EmailVerificationError) {
                context.navigator
                    .goToUpdateEmailFailurePage(error: state.error);
              } else if (authState is AuthSignedIn &&
                  state is EmailVerificationSuccess) {
                BlocProvider.of<UpdateLoginCubit>(context).request();
              } else if (state is EmailVerificationError) {
                context.navigator
                    .goToEmailVerifyFailurePage(error: state.error);
              } else if (state is EmailVerificationSuccess) {
                context.navigator.goToEmailVerifySuccessPage();
              }
            },
            builder: (context, state) {
              return GradientBackground(
                gradient: LightColors.authenticationBackgroundGradient,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kSpacingExtraLarge,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: kSpacingMedium),
                            child: Text(
                              context.getLocalizationOf.verifyingEmailText,
                              style: context.tfbText.header3.copyWith(
                                color: TfbBrandColors.blueHighest,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Text(
                            context.getLocalizationOf.waitToVerifyEmail,
                            style: context.tfbText.bodyRegularLarge,
                          ),
                        ),
                        const SliverFillRemaining(
                          child: Center(
                            child: TfbBrandLoadingIcon(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
