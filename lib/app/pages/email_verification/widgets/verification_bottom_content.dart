import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/registration_resend/registration_resend_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class VerificationBottomContent extends StatelessWidget {
  const VerificationBottomContent({
    required this.registrationRequest,
    super.key,
  });

  final RegistrationResendRequest registrationRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: kSpacingMedium,
            bottom: kSpacingSmall,
          ),
          child: GestureDetector(
            onTap: () {
              context
                  .read<RegistrationResendCubit>()
                  .resendRegistration(registrationRequest);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: kSpacingExtraSmall,
                  ),
                  child: Text(
                    context.getLocalizationOf.didntReceiveText,
                    style: context.tfbText.bodyMediumLarge,
                  ),
                ),
                Text(
                  context.getLocalizationOf.resendText,
                  style: context.tfbText.bodyMediumLarge.copyWith(
                    color: TfbBrandColors.blueHigh,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
