import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/registration/registration_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_account_button.dart';
import 'package:txfb_insurance_flutter/app/pages/create_account/widgets/register_form.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({required this.registrationRepo, super.key});

  final TfbMemberRegistrationRepository registrationRepo;
  final isFormValid = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (context) => RegistrationBloc(repository: registrationRepo),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TfbAnimatedAppBar(
              titleString: context.getLocalizationOf.registrationTitle,
              backgroundColor: TfbBrandColors.grayLow,
              showCancelButton: true,
              onCancelPressed: context.navigator.goToLoginPage,
              automaticallyImplyLeading: false,
            ),
            body: TfbDropShadowScrollWidget(
              child: GradientBackground(
                showLoadingOverlay: state is RegistrationProcessingState,
                gradient: LightColors.authenticationBackgroundGradient,
                child: ScrollableViewWithPinnedButton(
                  button: ValueListenableBuilder(
                    valueListenable: isFormValid,
                    builder: (context, isValid, _) {
                      return RegisterAccountButton(
                        disabled: !isValid,
                        onPressed: () {
                          BlocProvider.of<RegistrationBloc>(context).add(
                            RegistrationFormCompletedEvent(),
                          );
                        },
                      );
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ListView(
                      children: [
                        Text(
                          context.getLocalizationOf.registrationTitle,
                          style: context.tfbText.header3.copyWith(
                            color: TfbBrandColors.blueHighest,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: kSpacingMedium),
                          child: Text(
                            context.getLocalizationOf.registrationSubTitle,
                            style: context.tfbText.bodyRegularLarge.copyWith(
                              color: LightColors.tertiary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: kSpacingMedium),
                          child: RegisterForm(
                            formKey: formKey,
                            isFormValid: isFormValid,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
