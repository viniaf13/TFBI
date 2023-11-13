import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/member_access/user_information.dart';

class UpdateLoginCubit extends TfbSingleRequestCubit<List<UserInformation>> {
  UpdateLoginCubit({
    required TfbMemberAccessClient memberAccessClient,
    required String memberNumber,
  }) : super(
          requestFunction: () =>
              memberAccessClient.fetchMemberLogin(memberNumber),
        );
}
