import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/delete_account/delete_account_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/delete_account_confirmation_modal.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/mixins/full_screen_loading_overlay_mixin.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class DeleteAccountListTile extends StatefulWidget {
  const DeleteAccountListTile({super.key});

  @override
  State<DeleteAccountListTile> createState() => _DeleteAccountListTileState();
}

class _DeleteAccountListTileState extends State<DeleteAccountListTile>
    with FullScreenLoadingOverlay {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountFailed) {
          hideFullscreenLoadingOverlay();
          context.showErrorSnackBar(
            text: state.error.message,
          );
        } else if (state is DeleteAccountSuccess) {
          hideFullscreenLoadingOverlay();
          TfbApp.clearAppData();
          context.navigator.goToLoginPage(isLoggingOut: true);
        }
      },
      child: ListTile(
        title: Text(
          context.getLocalizationOf.myAccountDeleteCTA,
          textAlign: TextAlign.center,
          style: context.tfbText.bodyBoldSmall
              .copyWith(color: TfbBrandColors.redHigh),
        ),
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) {
              TfbAnalytics.instance.track(const DeleteAccountModalView());
              return BlocProvider.value(
                value: context.read<DeleteAccountCubit>(),
                child: BlocListener<DeleteAccountCubit, DeleteAccountState>(
                  listener: (context, state) {
                    if (state is DeleteAccountProcessing) {
                      Navigator.pop(context);
                    }
                    if (state is DeleteAccountProcessing) {
                      Navigator.pop(context);

                      showFullscreenLoadingOverlay(context: context);
                    }
                  },
                  child: const DeleteAccountConfirmationModal(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
