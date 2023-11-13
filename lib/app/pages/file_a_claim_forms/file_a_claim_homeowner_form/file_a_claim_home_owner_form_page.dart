import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/file_a_claim_homeowner_form/file_a_claim_home_owner_form_content.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

class FileAClaimHomeOwnerPage extends StatefulWidget {
  const FileAClaimHomeOwnerPage({
    required this.dateOfLoss,
    required this.policySelection,
    super.key,
  });

  final String dateOfLoss;
  final PolicySelection policySelection;

  @override
  State<FileAClaimHomeOwnerPage> createState() =>
      _FileAClaimHomeOwnerPageState();
}

class _FileAClaimHomeOwnerPageState extends State<FileAClaimHomeOwnerPage> {
  @override
  Widget build(BuildContext context) {
    final userAccessToken = context.listenToAccessToken();
    final apiUrl = context.getEnvironment<TfbEnvironment>().apiUrl;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: BlocProvider(
        create: (context) => SubmitClaimBloc(
          fileClaimRepo: TfbFileClaimRepository(
            fileClaimClient: FileAClaimClient(
              baseUrl: apiUrl,
              dio: TfbClient.createAuthenticatedDio(userAccessToken!),
            ),
            documentClient: context.read<TfbDocumentInformationClient>(),
            policyLookUp: context.read<TfbPolicyLookupRepository>(),
          ),
        ),
        child: FileAClaimHomeOwnerContent(
          dateOfLoss: widget.dateOfLoss,
          policySelection: widget.policySelection,
        ),
      ),
    );
  }
}
