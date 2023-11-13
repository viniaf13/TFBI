import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/add_photos_page_content.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:plugin_haven/util/context_extension.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class AddPhotosPage extends StatelessWidget {
  const AddPhotosPage({
    required this.claim,
    super.key,
  });

  final ClaimSubmission claim;

  @override
  Widget build(BuildContext context) {
    final userAccessToken = context.listenToAccessToken();
    final apiUrl = context.getEnvironment<TfbEnvironment>().apiUrl;
    return BlocProvider(
      create: (context) => SubmitClaimBloc(
        fileClaimRepo: TfbFileClaimRepository(
          fileClaimClient: context.read<FileAClaimClient>(),
          documentClient: context.read<TfbDocumentInformationClient>(),
          policyLookUp: context.read<TfbPolicyLookupRepository>(),
        ),
      ),
      child: AddPhotosPageContent(
        claim: claim,
        apiUrl: apiUrl,
        userAccessToken: userAccessToken!,
      ),
    );
  }
}
