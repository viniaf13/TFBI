import 'package:txfb_insurance_flutter/domain/models/member_lookup/contact.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem({required this.contact, super.key});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contact.fullName.toTitleCase(),
            style: context.tfbText.bodyMediumSmall,
          ),
          Text(
            contact.phoneNumber,
            style: context.tfbText.subHeaderLight,
          ),
        ],
      ),
    );
  }
}
