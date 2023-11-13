import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_list/billing_document_list_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_document_list/billing_document_pageview.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class BillingDocumentListBuilder extends StatelessWidget {
  const BillingDocumentListBuilder({
    required this.pageViewController,
    required this.pageSize,
    super.key,
  });

  final PageController pageViewController;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillingDocumentListCubit, TfbSingleRequestState>(
      listener: (context, state) {
        if (state is TfbSingleRequestFailed) {
          context.showErrorSnackBar(text: state.error.message);
        }
      },
      builder: (context, state) {
        if (state is TfbSingleRequestProcessing) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingLarge),
              child: TfbBrandLoadingIcon(
                thickness: LoadingOverlayThickness.thick,
                size: Size.fromHeight(48),
              ),
            ),
          );
        } else if (state is TfbSingleRequestFailed) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              kSpacingMedium,
              0,
              kSpacingMedium,
              kSpacingMedium,
            ),
            child: Text(
              context.getLocalizationOf.billingDocumentsLoadError,
              style: context.tfbText.subHeaderRegular
                  .copyWith(color: TfbBrandColors.redHigh),
              textAlign: TextAlign.start,
            ),
          );
        }

        if (state is! TfbSingleRequestSuccess<List<BillingListMetadata>>) {
          return const SizedBox.shrink();
        }

        if (state.response.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              kSpacingMedium,
              0,
              kSpacingMedium,
              kSpacingMedium,
            ),
            child: Text(
              context.getLocalizationOf.emptyBillingDocuments,
              style: context.tfbText.subHeaderRegular,
              textAlign: TextAlign.start,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: kSpacingSmall),
          child: BillingDocumentPageView(
            pageViewController: pageViewController,
            billingDocuments: state.response,
            pageSize: pageSize,
          ),
        );
      },
    );
  }
}
