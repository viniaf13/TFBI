import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/member_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_lookup/contact.dart';

class ContactsCubit extends TfbSingleRequestCubit<List<Contact>> {
  ContactsCubit({
    required TfbMemberLookupClient client,
    required String memberNumber,
  }) : super(requestFunction: () => client.getContacts(memberNumber));

  void pullToRefreshContacts() {
    request(pullToRefresh: true);
  }
}
