import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/haven.dart';
import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/blocs/autopay/autopay_bloc.dart';
import 'package:txfb_insurance_flutter/app/blocs/claims/claims_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/contacts/contacts_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/member_summary/member_summary_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/data/data.dart';
import 'package:txfb_insurance_flutter/data/network/clients/tfb_client.dart';
import 'package:txfb_insurance_flutter/device/environment/tfb_environment.dart';
import 'package:txfb_insurance_flutter/domain/clients/claims_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/file_a_claim_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/member_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/policy_lookup_client.dart';
import 'package:txfb_insurance_flutter/domain/clients/tfb_member_access_client.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_claims_client_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/utils/tab_tap_notifier.dart';

/// Providers that should be available in the widget tree only when the user
/// is fully authenticated in the [AuthSignedIn] state.
class TfbAuthenticatedProviders extends StatelessWidget {
  const TfbAuthenticatedProviders(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final apiBaseUrl = context.getEnvironment<TfbEnvironment>().apiUrl;
    final userAccessToken = context.listenToAccessToken();
    final memberNumber = context.getUserMemberNumber;

    if (userAccessToken.isNullOrEmpty || memberNumber.isNullOrEmpty) {
      return child;
    }

    final sharedAuthenticatedDio =
        TfbClient.createAuthenticatedDio(userAccessToken!);

    return MultiProvider(
      providers: [
        Provider(
          create: (context) => TfbPolicyLookupRepository(
            accessToken: userAccessToken,
            client: TfbPolicyLookupClient(
              baseUrl: apiBaseUrl,
              dio: sharedAuthenticatedDio,
            ),
          ),
        ),
        Provider(
          create: (context) => TfbDocumentInformationRepository(
            client: TfbDocumentInformationClient(
              baseUrl: apiBaseUrl,
              dio: sharedAuthenticatedDio,
            ),
          ),
        ),
        Provider(
          create: (_) => TfbMemberLookupClient(
            baseUrl: apiBaseUrl,
            dio: sharedAuthenticatedDio,
          ),
        ),
        Provider(
          create: (context) => TfbMemberAccessClient(
            baseUrl: apiBaseUrl,
            dio: sharedAuthenticatedDio,
          ),
        ),
        Provider(
          create: (context) => TfbDocumentInformationClient(
            baseUrl: apiBaseUrl,
            dio: sharedAuthenticatedDio,
          ),
        ),
        Provider(
          create: (context) => FileAClaimClient(
            baseUrl: apiBaseUrl,
            dio: sharedAuthenticatedDio,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TabTapNotifier(null),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MemberSummaryCubit(
              repository: context.read<TfbPolicyLookupRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ContactsCubit(
              client: context.read<TfbMemberLookupClient>(),
              memberNumber: memberNumber!,
            ),
          ),
          BlocProvider(
            create: (context) => ClaimsBloc(
              claimsRepository: TfbClaimsClientRepository(
                client: ClaimsClient(
                  baseUrl: apiBaseUrl,
                  dio: sharedAuthenticatedDio,
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => AutopayBloc(
              repository: context.read<TfbPolicyLookupRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => StatusBarScrollCubit(),
          ),
        ],
        child: child,
      ),
    );
  }
}
