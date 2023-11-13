import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

/// This consumer is provided as an assist for hooking up to the UI layer in
/// [TFBI-509] Billing Details - Paperless Billing - UI, Error State
class PaperlessLookupConsumer extends StatelessWidget {
  const PaperlessLookupConsumer({required this.policy, super.key});

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    Widget childWidget = const TfbBrandLoadingIcon();

    return BlocConsumer<PaperlessLookupCubit, PaperlessLookupState>(
      listener: (context, state) {
        if (state is PaperlessLookupInitState) {
          /// Make the api call => `getPaperlessAccountDetails(policy)`
        }

        if (state is PaperlessLookupFailureState) {
          /// Failures/Errors can come from two events.
          /// A failure in the attempt to make the API call which will return
          /// the default generic message OR a server side error. The
          /// PaperlessLookupResponse object contains an `errorMessage` field
          /// that will not be empty.
        }
      },
      builder: (context, state) {
        if (state is PaperlessLookupProcessingState) {
          childWidget = const TfbBrandLoadingIcon();
        }

        if (state is PaperlessLookupSuccessState) {
          /// Use state.response [PaperlessLookupResponse] to build the
          /// notification widgets. PaperlessLookupResponse.memberEnrollmentType
          /// indicates if the user receives email or text notifications or both.
        }

        return childWidget;
      },
    );
  }
}
