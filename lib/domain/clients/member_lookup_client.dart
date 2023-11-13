// coverage:ignore-file
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_lookup/contact.dart';

part 'member_lookup_client.g.dart';

const kMemberLookupRootEndpoint = '/services/TFBIC.Services.RESTMember.Lookup';
const kContactsLookupEndpoint =
    '$kMemberLookupRootEndpoint/contacts/{memberNumber}';

@RestApi(baseUrl: kStageApiBaseUrl)
abstract class TfbMemberLookupClient extends TfbClient {
  factory TfbMemberLookupClient({
    required String baseUrl,
    required Dio dio,
  }) =>
      _TfbMemberLookupClient(
        dio,
        baseUrl: baseUrl,
      );

  @GET(kContactsLookupEndpoint)
  Future<List<Contact>> getContacts(
    @Path('memberNumber') String memberNumber,
  );
}
