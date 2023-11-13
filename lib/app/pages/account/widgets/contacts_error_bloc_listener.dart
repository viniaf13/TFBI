import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ContactsErrorBlocListener extends StatelessWidget {
  const ContactsErrorBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsCubit, TfbSingleRequestState>(
      listener: (context, state) {
        if (state is TfbSingleRequestFailed) {
          context.showErrorSnackBar(
            text: context.getLocalizationOf.somethingWentWrong,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
