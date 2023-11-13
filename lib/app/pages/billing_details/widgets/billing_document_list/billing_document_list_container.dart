import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_list/billing_document_list_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/tfb_single_request_cubit/tfb_single_request_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/card_title.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/page_view_controls.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/billing_document_list/billing_document_list_builder.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/billing/billing_list_metadata.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class BillingDocumentListContainer extends StatefulWidget {
  const BillingDocumentListContainer({required this.policy, super.key});

  final PolicySummary policy;

  @override
  State<BillingDocumentListContainer> createState() =>
      _BillingDocumentListContainerState();
}

class _BillingDocumentListContainerState
    extends State<BillingDocumentListContainer> {
  final pageViewController = PageController();
  final pageSize = 5;

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      // Updates the PageViewControls currentPage
      setState(() {});
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<BillingDocumentListCubit>().state
        is TfbSingleRequestInitial) {
      context.read<BillingDocumentListCubit>().request(
            fallbackRequest: () => BillingDocumentListCubit.createRequest(
              context.read<TfbDocumentInformationClient>(),
              widget.policy,
            ),
          );
    }

    num currentPage;

    try {
      currentPage = ((pageViewController.page ?? 0) + 1).round();
    } catch (_) {
      currentPage = 1;
    }

    return BlocBuilder<BillingDocumentListCubit, TfbSingleRequestState>(
      builder: (context, state) {
        return Card(
          margin: EdgeInsets.zero,
          semanticContainer: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(
                title: context.getLocalizationOf.billingDocumentsContainerTitle,
              ),
              BillingDocumentListBuilder(
                pageViewController: pageViewController,
                pageSize: pageSize,
              ),
              if (state is TfbSingleRequestProcessing ||
                  (state is TfbSingleRequestSuccess<
                          List<BillingListMetadata>> &&
                      state.response.isNotEmpty))
                PageViewControls(
                  pageViewController: pageViewController,
                  currentPage: currentPage,
                  showPageCount: state is TfbSingleRequestSuccess,
                  maxPages: (state
                          is TfbSingleRequestSuccess<List<BillingListMetadata>>)
                      ? (state.response.length / pageSize).ceil()
                      : 1,
                ),
            ],
          ),
        );
      },
    );
  }
}
