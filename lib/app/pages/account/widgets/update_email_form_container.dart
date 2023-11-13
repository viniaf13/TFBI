import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/current_email_display.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/update_email_form.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/update_email_listener.dart';
import 'package:txfb_insurance_flutter/data/data_validators/tfb_email_validator.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

const _defaultAnimationDuration = Duration(milliseconds: 300);

class UpdateEmailFormContainer extends StatelessWidget {
  const UpdateEmailFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final emailValidator = TfbEmailValidator.localizedForgotPassword(context);
    final emailController = TextEditingController();
    final isEmailValid = ValueNotifier(false);
    final isOpenListenable = ValueNotifier(false);

    return UpdateEmailConsumer(
      builder: (context, state) {
        final isLoading = state is TfbSingleRequestProcessing;

        return AnimatedSize(
          alignment: Alignment.topCenter,
          curve: Curves.easeIn,
          duration: _defaultAnimationDuration,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IgnorePointer(
                ignoring: isLoading,
                child: AnimatedOpacity(
                  duration: _defaultAnimationDuration,
                  opacity: isLoading ? 0.4 : 1.0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(
                      kSpacingMedium,
                      kSpacingMedium,
                      kSpacingMedium,
                      kSpacingMedium,
                    ),
                    decoration: ShapeDecoration(
                      color: TfbBrandColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: context.radii.defaultRadius,
                      ),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isOpenListenable,
                      builder: (context, isOpen, child) {
                        return Column(
                          children: [
                            CurrentEmailDisplay(
                              onTap: () {
                                isOpenListenable.value = !isOpen;
                                if (isOpen) {
                                  emailController.text = '';
                                  isEmailValid.value = false;
                                }
                              },
                              isOpen: isOpen,
                            ),
                            if (isOpen)
                              UpdateEmailForm(
                                emailController: emailController,
                                emailValidator: emailValidator,
                                isEmailValidNotifier: isEmailValid,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (isLoading)
                const Positioned.fill(
                  child: Align(
                    child: TfbBrandLoadingIcon(
                      thickness: LoadingOverlayThickness.thick,
                      size: Size.fromHeight(48),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
