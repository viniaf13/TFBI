import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/login_form.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/offline_content_container.dart';
import 'package:txfb_insurance_flutter/app/pages/login/widgets/splash_screen/animated_welcome_row.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class LoginPageContent extends StatelessWidget {
  const LoginPageContent({
    required this.controller,
    required this.curve,
    required this.endIconKey,
    super.key,
  });

  final AnimationController controller;
  final Curve curve;
  final GlobalKey endIconKey;

  @override
  Widget build(BuildContext context) {
    final positionTween = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpacingSmall,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              AnimatedWelcomeRow(
                controller: controller,
                curve: curve,
                starWidgetKey: endIconKey,
              ),
              Transform.translate(
                offset: Offset(
                  0,
                  MediaQuery.sizeOf(context).height * positionTween.value,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: kSpacingLarge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LoginForm(),
                      OfflineContentContainer(
                        autoPolicyDocumentMetadataRepository: context
                            .read<TfbAutoPolicyDocumentMetadataRepository>(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
