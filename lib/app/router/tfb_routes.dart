// coverage:ignore-file
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:plugin_haven/haven.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/app/cubits/agent_cubit/agent_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy/auto_policy_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document/auto_policy_document_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/auto_policy_document_pdf/auto_policy_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/autopay_enrollment/routing_number_validation_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/current_bill/current_billing_doc_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/ebill_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing/paperless_lookup/paperless_lookup_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_list/billing_document_list_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/billing_document_pdf/billing_document_pdf_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/save_auto_id_card/save_auto_id_card_cubit.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/add_photos/add_photos_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/auto_pay_enrollment_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/auto_pay_enrollment_success_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/auto_pay_enrollment/discontinue_auto_pay_enrollment_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/billing.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/current_bill/current_bill_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_details/widgets/payment_dialog/make_payment_dialog.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_document_pdf_viewer/billing_document_pdf_viewer_page.dart';
import 'package:txfb_insurance_flutter/app/pages/customer_service/customer_service_page.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim/file_a_claim_page.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_auto_success/file_a_claim_auto_success_page.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/file_a_claim_auto_form/file_an_auto_claim_form_page.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/file_a_claim_homeowner_form/file_a_claim_home_owner_form_page.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/file_a_claim_cancel_dialog.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_forms/widgets/go_to_settings_dialog.dart';
import 'package:txfb_insurance_flutter/app/pages/file_a_claim_homeowner_success/file_a_claim_homeowner_success_page.dart';
import 'package:txfb_insurance_flutter/app/pages/insurance_card/insurance_card_page.dart';
import 'package:txfb_insurance_flutter/app/pages/one_time_payment/authenticated_one_time_payment_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_detail_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/widgets/insurance_card_viewer_page.dart';
import 'package:txfb_insurance_flutter/app/pages/roadside_assistance/roadside_assistance_page.dart';
import 'package:txfb_insurance_flutter/app/pages/web_viewer/web_viewer_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_dialog_transition_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router_query_params.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_slide_transition_page.dart';
import 'package:txfb_insurance_flutter/device/cookies/tfb_authenticated_payments_cookie_manager.dart';
import 'package:txfb_insurance_flutter/domain/clients/document_information_client.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_auto_success.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_homeowner_success.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_info.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_agent_lookup_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_auto_policy_document_metadata_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_document_information_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_pdf_storage_repository.dart';
import 'package:txfb_insurance_flutter/domain/repositories/tfb_policy_lookup_repository.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

/// Represents the app routes and their paths.
enum TfbAppRoutes {
  login(
    relativePath: '/',
    absolutePath: '/',
  ),
  dashboard(
    relativePath: '/dashboard',
    absolutePath: '/dashboard',
  ),
  policies(
    relativePath: '/policies',
    absolutePath: '/policies',
  ),
  policyDetail(
    relativePath: 'policyDetail',
    absolutePath: '/policyDetail',
  ),
  account(
    relativePath: '/account',
    absolutePath: '/account',
  ),
  appInfo(
    relativePath: 'appInfo',
    absolutePath: '/account/appInfo',
  ),
  billing(
    relativePath: '/billing',
    absolutePath: '/billing',
  ),
  billingDetail(
    relativePath: 'billingDetails',
    absolutePath: '/billing/billingDetails',
  ),
  autoPayEnrollment(
    relativePath: 'autoPaymentEnrollment',
    absolutePath: '/billing/autoPaymentEnrollment',
  ),
  autoPayEnrollmentSuccess(
    relativePath: 'autoPayEnrollmentSuccess',
    absolutePath: '/billing/autoPayEnrollmentSuccess',
  ),
  autoPayEnrollmentDiscontinuePage(
    relativePath: 'autoPayEnrollmentDiscontinuePage',
    absolutePath: '/billing/autoPayEnrollmentDiscontinuePage',
  ),
  authenticatedOneTimePayment(
    relativePath: 'oneTimePayment',
    absolutePath: '/billing/billingDetails/oneTimePayment',
  ),
  changePassword(
    relativePath: 'changePassword',
    absolutePath: '/account/changePassword',
  ),
  changePasswordSuccess(
    relativePath: 'changePasswordSuccess',
    absolutePath: '/account/changePassword/changePasswordSuccess',
  ),
  accountVerifyUpdateEmail(
    relativePath: 'verifyUpdatedEmail',
    absolutePath: '/account/verifyUpdatedEmail',
  ),
  accountVerifyUpdateComplete(
    relativePath: 'complete',
    absolutePath: '/account/verifyUpdatedEmail/complete',
  ),
  claims(
    relativePath: '/claims',
    absolutePath: '/claims',
  ),
  fileAClaim(
    relativePath: 'fileAClaim',
    absolutePath: '/fileAClaim',
  ),
  fileAClaimHomeOwnerFilePage(
    relativePath: 'fileAClaimHomeOwnerFilePage',
    absolutePath: '/claims/fileAClaim/fileAClaimHomeOwnerFilePage',
  ),
  fileAClaimHomeOwnerSuccessPage(
    relativePath: 'fileAClaimHomeOwnerSuccessPage',
    absolutePath:
        '/claims/fileAClaim/fileAClaimHomeOwnerFilePage/addPhotosPageHomeOwner/fileAClaimHomeOwnerSuccessPage',
  ),
  fileAnAutoClaimFilePage(
    relativePath: 'fileAnAutoClaimFilePage',
    absolutePath: '/claims/fileAClaim/fileAnAutoClaimFilePage',
  ),
  fileAClaimPersonalAutoSuccessPage(
    relativePath: 'fileAClaimPersonalAutoSuccessPage',
    absolutePath:
        '/claims/fileAClaim/fileAnAutoClaimFilePage/addPhotosPageAuto/fileAClaimPersonalAutoSuccessPage',
  ),
  createAccount(
    relativePath: 'createAccount',
    absolutePath: '/createAccount',
  ),
  emailVerify(
    relativePath: 'emailVerify',
    absolutePath: '/createAccount/emailVerify',
  ),
  emailVerifyDeepLink(
    relativePath: 'policyholder/manage-account/validate-email',
    absolutePath: '/policyholder/manage-account/validate-email',
  ),
  emailVerifyFailureOrSuccess(
    relativePath: 'emailVerifyFailureOrSuccess',
    absolutePath:
        '/policyholder/manage-account/validate-email/emailVerifyFailureOrSuccess',
  ),
  forgotPassword(
    relativePath: 'forgotPassword',
    absolutePath: '/forgotPassword',
  ),
  forgotPasswordVerification(
    relativePath: 'verifyForgotPassword/:email',
    absolutePath: '/forgotPassword/verifyForgotPassword/:email',
  ),
  forgotPasswordUpdate(
    relativePath: 'policyholder/manage-account/password-reset',
    absolutePath: '/policyholder/manage-account/password-reset',
  ),
  forgotPasswordUpdateSuccess(
    relativePath: 'success',
    absolutePath: '/policyholder/manage-account/password-reset/success',
  ),
  viewInsuranceCardPdf(
    relativePath: 'viewInsuranceCardPdf',
    absolutePath: '/viewInsuranceCardPdf',
  ),
  viewPolicyDocumentPdf(
    relativePath: 'viewPolicyDocumentPdf',
    absolutePath: '/viewPolicyDocumentPdf',
  ),
  viewCurrentBillPdf(
    relativePath: 'viewCurrentBillPdf',
    absolutePath: '/viewCurrentBillPdf',
  ),
  roadsideAssistance(
    relativePath: 'roadsideAssistance',
    absolutePath: '/roadsideAssistance',
  ),
  customerService(
    relativePath: 'customerService',
    absolutePath: '/customerService',
  ),
  makeAPaymentDialog(
    relativePath: 'makeAPaymentDialog',
    absolutePath: '/makeAPaymentDialog',
  ),
  billingDocumentPdfViewer(
    relativePath: 'billingDocumentPdfViewer',
    absolutePath: '/billingDocumentPdfViewer',
  ),
  addPhotosPageAuto(
    relativePath: 'addPhotosPageAuto',
    absolutePath:
        '/claims/fileAClaim/fileAnAutoClaimFilePage/addPhotosPageAuto',
  ),
  addPhotosPageHomeOwner(
    relativePath: 'addPhotosPageHomeOwner',
    absolutePath:
        '/claims/fileAClaim/fileAClaimHomeOwnerFilePage/addPhotosPageHomeOwner',
  ),
  webViewerPage(
    relativePath: 'webViewerPage',
    absolutePath: '/webViewerPage',
  ),
  insuranceCardPage(
    relativePath: 'insuranceCard',
    absolutePath: '/insuranceCard',
  ),
  goToSettingsDialog(
    relativePath: 'goToSettingsDialog',
    absolutePath: '/goToSettingsDialog',
  ),
  goToCancelClaimsDialog(
    relativePath: 'goToCancelClaimsDialog',
    absolutePath: '/goToCancelClaimsDialog',
  );

  const TfbAppRoutes({
    required this.relativePath,
    required this.absolutePath,
  });

  /// The path of a page relative to the parent page it's embedded in
  ///
  /// Relative paths cannot begin or end with a slash (/) character. Used for
  /// setting up the router, but not for navigation.
  final String relativePath;

  /// The absolute path of a page from the root location /
  ///
  /// Used for navigation, but not for setting up the router.
  final String absolutePath;
}

// Reusable relative route configs that may appear in multiple stacks
// (e.g. get pushed onto stack)
abstract class TfbNamedRoute {
  static GoRoute get viewInsuranceCard => GoRoute(
        path: TfbAppRoutes.insuranceCardPage.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          return TfbSlideTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<SaveAutoIdCardCubit>(
                  create: (context) {
                    return SaveAutoIdCardCubit(
                      metadataRepository: context
                          .read<TfbAutoPolicyDocumentMetadataRepository>(),
                      documentRepository:
                          context.read<TfbPdfStorageRepository>(),
                      documentInformationRepository:
                          context.read<TfbDocumentInformationRepository>(),
                    );
                  },
                ),
                BlocProvider<AutoPolicyCubit>(
                  create: (context) => AutoPolicyCubit(
                    documentInformationRepository:
                        context.read<TfbDocumentInformationRepository>(),
                  ),
                ),
              ],
              child: InsuranceCardPage(
                params: state.extra as InsuranceCardPageParameters,
              ),
            ),
          );
        },
      );

  static GoRoute get policyDetails => GoRoute(
        path: TfbAppRoutes.policyDetail.relativePath,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<SaveAutoIdCardCubit>(
                create: (context) {
                  return SaveAutoIdCardCubit(
                    metadataRepository:
                        context.read<TfbAutoPolicyDocumentMetadataRepository>(),
                    documentRepository: context.read<TfbPdfStorageRepository>(),
                    documentInformationRepository:
                        context.read<TfbDocumentInformationRepository>(),
                  );
                },
              ),
              BlocProvider<AutoPolicyCubit>(
                create: (context) => AutoPolicyCubit(
                  documentInformationRepository:
                      context.read<TfbDocumentInformationRepository>(),
                ),
              ),
              BlocProvider<AgentCubit>(
                create: (context) => AgentCubit(
                  repository: context.read<TfbAgentLookupRepository>(),
                ),
              ),
              BlocProvider<WalletCubit>(
                create: (context) => WalletCubit(),
              ),
              BlocProvider<AutoPolicyDocumentCubit>(
                create: (context) => AutoPolicyDocumentCubit(
                  documentInformationRepository:
                      context.read<TfbDocumentInformationRepository>(),
                ),
              ),
            ],
            child: Builder(
              builder: (context) {
                TfbAnalytics.instance
                    .track(const PoliciesDetailsScreenViewEvent());
                if (state.extra is PolicySummary) {
                  return PolicyDetailPage(state.extra as PolicySummary);
                } else {
                  final summary = PolicySummary.fromJson(
                    state.extra as Map<String, dynamic>,
                  );
                  return PolicyDetailPage(summary);
                }
              },
            ),
          );
        },
        routes: [
          viewCurrentBillPdf,
          viewInsuranceCardPdf,
          billingDetails,
          viewPolicyDocumentPdf,
          makeAPaymentDialog,
          oneTimePayment,
          autoPayEnrollment,
          viewInsuranceCard,
          webViewerPage,
        ],
      );

  static GoRoute get billingDetails => GoRoute(
        path: TfbAppRoutes.billingDetail.relativePath,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BillingDocumentListCubit(),
            ),
            BlocProvider(
              create: (context) => PaperlessLookupCubit(
                repository: context.read<TfbPolicyLookupRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => EbillLookupCubit(
                repository: context.read<TfbPolicyLookupRepository>(),
              ),
            ),
          ],
          child: Builder(
            builder: (context) {
              TfbAnalytics.instance.track(const BillingDetailsPageEvent());
              if (state.extra is PolicySummary) {
                return BillingDetailsPage(
                  policy: state.extra as PolicySummary,
                  locationQueryParameters: state
                          .uri.queryParameters[TfbRouterQueryParams.location] ??
                      '',
                );
              } else {
                final summary =
                    PolicySummary.fromJson(state.extra as Map<String, dynamic>);
                return BillingDetailsPage(
                  policy: summary,
                  locationQueryParameters: state
                          .uri.queryParameters[TfbRouterQueryParams.location] ??
                      '',
                );
              }
            },
          ),
        ),
        routes: [
          viewCurrentBillPdf,
          makeAPaymentDialog,
          oneTimePayment,
          billingDocumentPdfViewer,
          autoPayEnrollment,
        ],
      );

  static GoRoute get autoPayEnrollment => GoRoute(
        path: TfbAppRoutes.autoPayEnrollment.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          final policy = state.extra as PolicySummary;
          TfbAnalytics.instance.track(
            policy.isAutoPayEnabled
                ? const ManageAutoPayEvent()
                : const EnrollInAutoPayEvent(),
          );
          return TfbSlideTransitionPage(
            child: BlocProvider(
              create: (context) => RoutingValidationCubit(
                repository: context.read<TfbPolicyLookupRepository>(),
              ),
              child: AutoPayEnrollmentPage(
                policy: policy,
              ),
            ),
            key: state.pageKey,
          );
        },
        routes: [
          GoRoute(
            path: TfbAppRoutes.autoPayEnrollmentSuccess.relativePath,
            parentNavigatorKey: authenticatedNavigatorKey,
            builder: (context, state) {
              TfbAnalytics.instance.track(const EnrollInAutoPaySuccessEvent());

              return AutoPayEnrollmentSuccessPage(
                policy: state.extra as PolicySummary,
              );
            },
          ),
          discontinueAutoPayEnrollmentPage,
        ],
      );

  static GoRoute get discontinueAutoPayEnrollmentPage => GoRoute(
        path: TfbAppRoutes.autoPayEnrollmentDiscontinuePage.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        builder: (context, state) {
          TfbAnalytics.instance.track(
            const DiscontinueAutoPayScreenViewEvent(),
          );

          return DiscontinueAutoPayEnrollmentPage(
            policy: state.extra as PolicySummary,
          );
        },
      );

  static GoRoute get billingDocumentPdfViewer => GoRoute(
        path: TfbAppRoutes.billingDocumentPdfViewer.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          return TfbSlideTransitionPage(
            child: BlocProvider(
              create: (context) => BillingDocumentPdfCubit(
                client: context.read<TfbDocumentInformationClient>(),
                documentPdfRepository: context.read<TfbPdfStorageRepository>(),
              ),
              child: BillingDocumentPdfViewerPage(
                params: state.extra as BillingDocumentPdfViewerPageParameters,
              ),
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get viewCurrentBillPdf => GoRoute(
        path: TfbAppRoutes.viewCurrentBillPdf.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          return TfbSlideTransitionPage(
            child: BlocProvider<CurrentBillingDocCubit>(
              create: (context) => CurrentBillingDocCubit(
                documentRepository:
                    context.read<TfbDocumentInformationRepository>(),
                documentPdfRepository: context.read<TfbPdfStorageRepository>(),
              ),
              child: CurrentBillPage(
                params: state.extra as CurrentBillPageParameters,
              ),
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get viewPolicyDocumentPdf => GoRoute(
        path: TfbAppRoutes.viewPolicyDocumentPdf.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          return TfbSlideTransitionPage(
            child: BlocProvider<AutoPolicyDocumentPdfCubit>(
              create: (context) => AutoPolicyDocumentPdfCubit(
                documentInformationRepository:
                    context.read<TfbDocumentInformationRepository>(),
                documentPdfRepository: context.read<TfbPdfStorageRepository>(),
              ),
              child: PolicyDocumentPage(
                params: state.extra as PolicyDocumentPageParameters,
              ),
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get viewInsuranceCardPdf => GoRoute(
        parentNavigatorKey: authenticatedNavigatorKey,
        path: TfbAppRoutes.viewInsuranceCardPdf.relativePath,
        pageBuilder: (context, state) {
          return TfbSlideTransitionPage(
            key: state.pageKey,
            child: InsuranceCardViewerPage(
              params: state.extra as PdfViewerPageParameters,
            ),
          );
        },
      );

  static GoRoute get fileAClaim => GoRoute(
        path: TfbAppRoutes.fileAClaim.relativePath,
        builder: (context, state) {
          TfbAnalytics.instance.track(
            const BeginClaimViewEvent(),
          );
          return const FileAClaimPage();
        },
        routes: [
          fileAClaimPersonalAuto,
          fileAClaimHomeOwner,
          settingsDialog,
        ],
      );

  static GoRoute get customerService => GoRoute(
        path: TfbAppRoutes.customerService.relativePath,
        builder: (context, state) {
          TfbAnalytics.instance.track(
            const CustomerServiceScreenViewEvent(),
          );
          return BlocProvider<AgentCubit>(
            create: (context) => AgentCubit(
              repository: context.read<TfbAgentLookupRepository>(),
            ),
            child: const CustomerServicePage(),
          );
        },
      );

  static GoRoute get fileAClaimHomeOwner => GoRoute(
        parentNavigatorKey: authenticatedNavigatorKey,
        path: TfbAppRoutes.fileAClaimHomeOwnerFilePage.relativePath,
        pageBuilder: (context, state) {
          final extra = state.extra as PolicyInfo;

          return TfbSlideTransitionPage(
            child: FileAClaimHomeOwnerPage(
              policySelection: extra.policySelection,
              dateOfLoss: extra.dateOfLoss,
            ),
            key: state.pageKey,
          );
        },
        routes: [
          fileAClaimHomeOwnerSuccess,
          addPhotosPageHomeOwner,
          cancelClaimDialog,
        ],
      );

  static GoRoute get fileAClaimHomeOwnerSuccess => GoRoute(
        parentNavigatorKey: authenticatedNavigatorKey,
        path: TfbAppRoutes.fileAClaimHomeOwnerSuccessPage.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(
            const SubmitPropertyClaimSucessViewEvent(),
          );
          final extra = state.extra as PolicyHomeownerSuccess;
          return TfbSlideTransitionPage(
            child: FileAClaimHomeownerSuccessPage(
              policy: extra.policySelection,
              dateOfLoss: extra.dateOfLoss,
              confirmationNumber: extra.confirmationNumber,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get makeAPaymentDialog => GoRoute(
        path: TfbAppRoutes.makeAPaymentDialog.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          final policySummary = state.extra as PolicySummary;

          TfbAnalytics.instance.track(const MakeAPaymentModalEvent());
          return TfbDialogTransitionPage(
            child: MakePaymentDialog(
              policySummary: policySummary,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get fileAClaimPersonalAuto => GoRoute(
        routes: [
          addPhotosPageAuto,
          cancelClaimDialog,
        ],
        parentNavigatorKey: authenticatedNavigatorKey,
        path: TfbAppRoutes.fileAnAutoClaimFilePage.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(
            const AutoClaimFormViewEvent(),
          );
          final extra = state.extra as PolicyInfo;
          return TfbSlideTransitionPage(
            child: FileAnAutoClaimFormPage(
              policySelection: extra.policySelection,
              dateOfLoss: extra.dateOfLoss,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get fileAClaimPersonalAutoSuccess => GoRoute(
        parentNavigatorKey: authenticatedNavigatorKey,
        path: TfbAppRoutes.fileAClaimPersonalAutoSuccessPage.relativePath,
        pageBuilder: (context, state) {
          TfbAnalytics.instance.track(
            const SubmitAutoClaimSucessViewEvent(),
          );
          final extra = state.extra as PolicyAutoSuccess;
          return TfbSlideTransitionPage(
            child: FileAnAutoClaimSuccessPage(
              policySelection: extra.policySelection,
              dateOfLoss: extra.dateOfLoss,
              claimNumber: extra.claimNumber,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get roadsideAssistance => GoRoute(
        path: TfbAppRoutes.roadsideAssistance.relativePath,
        builder: (context, state) {
          TfbAnalytics.instance.track(
            const RoadsideAssistanceScreenViewEvent(),
          );

          return const RoadsideAssistancePage();
        },
        routes: [
          fileAClaim,
          webViewerPage,
        ],
      );

  static GoRoute get oneTimePayment => GoRoute(
        path: TfbAppRoutes.authenticatedOneTimePayment.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          final websiteUrl =
              context.getEnvironment<TfbEnvironment>().websiteUrl;
          final user = context.user!;

          final TfbAuthenticatedPaymentsCookieManager cookieManager =
              TfbAuthenticatedPaymentsCookieManager(
            setCookieString: user.sessionCookie!,
            accessTokenValue: user.accessToken,
            uri: Uri.parse(websiteUrl),
            cookieManager: CookieManager.instance(),
            accessTokenKey:
                context.getEnvironment<TfbEnvironment>().paymentsAccessTokenKey,
          );

          return TfbSlideTransitionPage(
            child: AuthenticatedOneTimePaymentPage(
              policy: state.extra as PolicySummary,
              paymentsCookieManager: cookieManager,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get addPhotosPageAuto => GoRoute(
        routes: [
          fileAClaimPersonalAutoSuccess,
        ],
        path: TfbAppRoutes.addPhotosPageAuto.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra as ClaimSubmission;
          return TfbSlideTransitionPage(
            child: AddPhotosPage(
              claim: extra,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get addPhotosPageHomeOwner => GoRoute(
        routes: [
          fileAClaimHomeOwnerSuccess,
        ],
        path: TfbAppRoutes.addPhotosPageHomeOwner.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra as ClaimSubmission;
          return TfbSlideTransitionPage(
            child: AddPhotosPage(
              claim: extra,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get webViewerPage => GoRoute(
        path: TfbAppRoutes.webViewerPage.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (context, state) {
          return TfbSlideTransitionPage(
            child: WebViewerPage(
              uri: state.extra as Uri,
            ),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get settingsDialog => GoRoute(
        path: TfbAppRoutes.goToSettingsDialog.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (_, state) {
          return TfbDialogTransitionPage(
            child: const GoToSettingsDialog(),
            key: state.pageKey,
          );
        },
      );

  static GoRoute get cancelClaimDialog => GoRoute(
        path: TfbAppRoutes.goToCancelClaimsDialog.relativePath,
        parentNavigatorKey: authenticatedNavigatorKey,
        pageBuilder: (_, state) {
          TfbAnalytics.instance.track(
            const CancelClaimModalViewEvent(),
          );
          final extra = state.extra as PolicySelection;
          return TfbDialogTransitionPage(
            child: CancelAClaimDialog(
              policy: extra,
            ),
            key: state.pageKey,
          );
        },
      );
}
