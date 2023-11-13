import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_registration_repository.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

/// Providers that should be available in the widget tree no matter your
/// authentication state.
class TfbUnauthenticatedProviders extends StatelessWidget {
  const TfbUnauthenticatedProviders(
    this.child, {
    this.navigator,
    super.key,
  });

  final Widget child;
  final TfbNavigator? navigator;

  @override
  Widget build(BuildContext context) {
    final unauthenticatedDio = context.readEnvConfig()?.unauthenticatedDio;

    if (unauthenticatedDio == null) {
      return child;
    }

    final localNavigator =
        navigator ?? TfbNavigator(router: GoRouter.of(context));

    final apiBaseUrl = context.getBaseUrl;

    return MultiProvider(
      providers: [
        Provider(create: (context) => localNavigator),
        Provider(
          create: (context) => TfbPdfStorageRepository(
            fileSystem: const LocalFileSystem(),
            getRootDirectory:
                getApplicationDocumentsDirectory().then((value) => value.path),
            getTempDirectory:
                getTemporaryDirectory().then((value) => value.path),
          ),
        ),
        Provider(
          create: (context) =>
              TfbAutoPolicyDocumentMetadataRepository.withDefaultDatabase(),
        ),
        Provider(
          create: (context) => TfbMemberAccessClient(
            baseUrl: apiBaseUrl,
            dio: unauthenticatedDio,
          ),
        ),
        Provider(
          create: (context) => TfbAgentLookupRepository(
            client: AgentLookUpClient(
              baseUrl: apiBaseUrl,
              dio: unauthenticatedDio,
            ),
          ),
        ),
        Provider(
          create: (context) => TfbMemberRegistrationRepository.fromBaseUrl(
            apiBaseUrl,
            unauthenticatedDio,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => StatusBarScrollCubit(),
        child: child,
      ),
    );
  }
}
