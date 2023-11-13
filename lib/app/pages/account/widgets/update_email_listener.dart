import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_email/update_email_cubit.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class UpdateEmailConsumer extends StatelessWidget {
  const UpdateEmailConsumer({required this.builder, super.key});

  final Widget Function(BuildContext context, TfbSingleRequestState state)
      builder;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateEmailCubit, TfbSingleRequestState>(
      listener: (context, state) {
        if (state is TfbSingleRequestFailed) {
          context.showErrorSnackBar(text: state.error.message);
        } else if (state is TfbSingleRequestSuccess) {
          context.navigator.goToAccountUpdatedEmailVerifyPage();
        }
      },
      builder: builder,
    );
  }
}
