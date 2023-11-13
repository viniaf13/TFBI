import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/contact_list_item.dart';
import 'package:txfb_insurance_flutter/domain/models/member_lookup/contact.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsCubit, TfbSingleRequestState>(
      builder: (context, state) => switch (state) {
        TfbSingleRequestFailed() => Text(
            context.getLocalizationOf.contactLoadingError,
            style:
                context.tfbText.caption.copyWith(color: TfbBrandColors.redHigh),
          ),
        TfbSingleRequestSuccess<List<Contact>>(response: final response) =>
          ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, item) => ContactListItem(
              contact: response
                  .where((element) => !element.phoneNumber.isNullOrEmpty)
                  .elementAt(item),
            ),
            separatorBuilder: (context, a) =>
                const SizedBox(height: kSpacingMedium),
            itemCount: response
                .where((element) => !element.phoneNumber.isNullOrEmpty)
                .length,
          ),
        _ => const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingLarge),
              child: TfbBrandLoadingIcon(
                thickness: LoadingOverlayThickness.thick,
                size: Size(48, 48),
              ),
            ),
          )
      },
    );
  }
}
