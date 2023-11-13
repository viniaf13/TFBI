import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_generic_api_response.dart';

class UpdateEmailCubit extends TfbSingleRequestCubit<TfbGenericApiResponse> {
  UpdateEmailCubit()
      : super(
          shouldCache: false,
          checkErrorInResponse: (response) =>
              response.errorMessage.isNullOrEmpty
                  ? null
                  : response.errorMessage,
        );
}
