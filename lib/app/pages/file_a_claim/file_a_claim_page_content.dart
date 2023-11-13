import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/claims_assistance.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/file_a_claim_section.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/widgets/how_claims_work_section.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';

class FileAClaimPageContent extends StatelessWidget {
  const FileAClaimPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TfbAnimatedAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kSpacingSmall,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: kSpacingMedium),
                child: FileAClaimSection(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSpacingMedium),
                child: HowClaimsWorkSection(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSpacingMedium),
                child: ClaimsAssistance(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
