import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ForgotPasswordBottomContent extends StatelessWidget {
  const ForgotPasswordBottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
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
                  if (state is ForgotPasswordRequestSuccess) {
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                      RequestForgotPasswordEvent(
                        state.email,
                      ),
                    );
                  }
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
      },
    );
  }
}
