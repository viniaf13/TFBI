import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/submit_claim/submit_claim_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/file_a_claim_page_content.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_file_claim_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:plugin_haven/plugin_haven.dart';

class FileAClaimPage extends StatelessWidget with PagePropertiesMixin {
  const FileAClaimPage({super.key});

  @override
  String get screenName => 'File a Claim Screen';

  @override
  Widget build(BuildContext context) {
    final userAccessToken = context.listenToAccessToken();
    final baseUrl = context.getEnvironment<TfbEnvironment>().apiUrl;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SubmitClaimBloc(
            fileClaimRepo: TfbFileClaimRepository(
              fileClaimClient: FileAClaimClient(
                baseUrl: baseUrl,
                dio: TfbClient.createAuthenticatedDio(userAccessToken!),
              ),
              documentClient: context.read<TfbDocumentInformationClient>(),
              policyLookUp: context.read<TfbPolicyLookupRepository>(),
            ),
          ),
        ),
      ],
      child: const FileAClaimPageContent(),
    );
  }
}
