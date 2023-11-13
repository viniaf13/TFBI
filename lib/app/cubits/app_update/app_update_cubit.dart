import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/models/app_update/app_update_response.dart';

class AppUpdateCubit extends TfbSingleRequestCubit<AppUpdateResponse> {
  static Future<AppUpdateResponse> checkAppVersion(
    TfbMemberAccessClient client,
  ) =>
      client.checkAppVersion();
}
