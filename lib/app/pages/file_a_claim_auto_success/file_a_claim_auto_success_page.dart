import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claim_details/claim_details_bloc.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/claims_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/context_extension.dart';

import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/file_a_claim_personal_auto_success_content.dart';

class FileAnAutoClaimSuccessPage extends StatefulWidget {
  const FileAnAutoClaimSuccessPage({
    required this.policySelection,
    required this.claimNumber,
    required this.dateOfLoss,
    super.key,
  });

  final PolicySelection policySelection;
  final String claimNumber;
  final String dateOfLoss;

  @override
  State<FileAnAutoClaimSuccessPage> createState() =>
      _FileAnAutoClaimFormPageState();
}

class _FileAnAutoClaimFormPageState extends State<FileAnAutoClaimSuccessPage> {
  @override
  Widget build(BuildContext context) {
    final userAccessToken = context.listenToAccessToken();
    final apiUrl = context.getEnvironment<TfbEnvironment>().apiUrl;

    return BlocProvider(
      create: (context) => ClaimDetailsBloc(
        claimsRepo: TfbClaimsClientRepository(
          client: ClaimsClient(
            baseUrl: apiUrl,
            dio: TfbClient.createAuthenticatedDio(userAccessToken!),
          ),
        ),
      ),
      child: FileAClaimPersonalAutoSuccessContent(
        policySelection: widget.policySelection,
        claimNumber: widget.claimNumber,
        dateOfLoss: widget.dateOfLoss,
      ),
    );
  }
}
