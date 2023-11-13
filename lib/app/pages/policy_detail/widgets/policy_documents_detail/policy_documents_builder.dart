import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document/auto_policy_document_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/policy_documents_detail.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/policy_documents_detail/policy_documents_error.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_brand_loading_icon.dart';

class PolicyDocumentsBuilder extends StatelessWidget {
  const PolicyDocumentsBuilder({
    required this.policy,
    super.key,
  });

  final PolicySummary policy;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoPolicyDocumentCubit, AutoPolicyDocumentState>(
      builder: (context, state) {
        if (state is AutoPolicyDocumentInitial) {
          context.read<AutoPolicyDocumentCubit>().getPolicyDocumentList(policy);
        }

        if (state is AutoPolicyDocumentSuccess) {
          if (state.noDocuments) {
            return const PolicyDocumentsError();
          } else {
            return PolicyDocumentsDetail(
              policy: policy,
              policyDocuments: state.policyDocuments,
              policyStaticDocuments: state.policyStaticDocuments,
            );
          }
        } else if (state is AutoPolicyDocumentError) {
          return const PolicyDocumentsError();
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacingLarge),
              child: TfbBrandLoadingIcon(
                thickness: LoadingOverlayThickness.thick,
                size: Size.fromHeight(48),
              ),
            ),
          );
        }
      },
    );
  }
}
