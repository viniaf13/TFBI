import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:txfb_insurance_flutter/app/pages/billing/current_bill/current_bill_page.dart';
import 'package:txfb_insurance_flutter/app/pages/billing_document_pdf_viewer/billing_document_pdf_viewer_page.dart';
import 'package:txfb_insurance_flutter/app/pages/insurance_card/insurance_card_page.dart';
import 'package:txfb_insurance_flutter/app/pages/pdf_viewer/tfb_pdf_viewer.dart';
import 'package:txfb_insurance_flutter/app/pages/policy_detail/policy_document/policy_document_page.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_router_query_params.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/file_a_claim/policy_selection.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/claim_submission.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_auto_success.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_homeowner_success.dart';
import 'package:txfb_insurance_flutter/domain/models/file_a_claim/policy_info.dart';
import 'package:txfb_insurance_flutter/domain/models/navigator_route_args.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/policy_summary.dart';
import 'package:txfb_insurance_flutter/domain/models/registration/registration_resend_request.dart';
import 'package:txfb_insurance_flutter/domain/models/tfb_request_error.dart';
import 'package:txfb_insurance_flutter/shared/utils/tfb_logger.dart';

class TfbNavigator {
  TfbNavigator({
    required this.router,
  });

  GoRouter router;

  /// Don't use this method directly unless you absolutely know what you're doing
  // ignore: non_constant_identifier_names
  void UNSAFE_goWithPath<T extends Object?>(
    String location,
  ) =>
      router.go(location);

  /// One global go method to replace any page on the navigation stack
  void _go(
    NavigatorRouteArgs args, {
    Map<String, dynamic>? queryParams,
  }) {
    TfbLogger.verbose('Navigator go screen', args);
    return router.go(
      Uri(
        path: args.route.absolutePath,
        queryParameters: queryParams,
      ).toString(),
      extra: args.extra,
    );
  }

  Future<Object?> _push(
    NavigatorRouteArgs args, {
    Map<String, dynamic> queryParams = const {},
  }) {
    TfbLogger.verbose('Navigator push screen', args);

    final destination = '$currentRelativePath/${args.route.relativePath}';

    return router.push(
      Uri(
        path: destination,
        queryParameters: queryParams,
      ).toString(),
      extra: args.extra,
    );
  }

  String get location => router.routerDelegate.currentConfiguration.fullPath;

  String get currentRelativePath {
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;

    return matchList.fullPath;
  }

  void popToTop() {
    TfbLogger.verbose('Navigator pop to top');

    while (router.canPop()) {
      router.pop();
    }
  }

  void pop() {
    router.pop();
  }

  /// Specific push methods for each page so the [extra] parameter in [context.go]
  /// is strongly typed.

  void goToDashboardPage() {
    _go(NavigatorRouteWithoutExtra(route: TfbAppRoutes.dashboard));
  }

  void goToLoginPage({bool? isLoggingOut}) {
    _go(
      NavigatorRouteWithoutExtra(route: TfbAppRoutes.login),
      queryParams: {
        TfbRouterQueryParams.loginPageSkipSplashAnimation: 'true',
        TfbRouterQueryParams.isLoggingOut: isLoggingOut.toString(),
      },
    );
  }

  void goToRegistrationPage<T extends Object?>() {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.createAccount,
      ),
    );
  }

  void goToForgotPasswordPage<T extends Object?>() {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.forgotPassword,
      ),
    );
  }

  void goToForgotPasswordVerifyPage<T extends Object?>(String email) {
    _go(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.forgotPasswordVerification,
        extra: email,
      ),
    );
  }

  void goToForgotPasswordUpdateSuccessPage<T extends Object?>() {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.forgotPasswordUpdateSuccess,
      ),
    );
  }

  void goToRegisterEmailVerifyPage<T extends Object?>(
    RegistrationResendRequest request,
  ) {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.emailVerify,
      ),
      queryParams: TfbRouterQueryParams.fromRegistrationRequest(request),
    );
  }

  void goToEmailVerifyFailurePage<T extends Object?>({
    required TfbRequestError error,
  }) {
    _go(
      NavigatorRouteWithExtra(
        extra: error,
        route: TfbAppRoutes.emailVerifyFailureOrSuccess,
      ),
    );
  }

  void goToUpdateEmailFailurePage<T extends Object?>({
    required TfbRequestError error,
  }) {
    _go(
      NavigatorRouteWithExtra(
        extra: error,
        route: TfbAppRoutes.accountVerifyUpdateComplete,
      ),
    );
  }

  void goToUpdateEmailSuccessPage<T extends Object?>() {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.accountVerifyUpdateComplete,
      ),
    );
  }

  void goToEmailVerifySuccessPage<T extends Object?>() {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.emailVerifyFailureOrSuccess,
      ),
    );
  }

  Future<Object?> pushPolicyDetailPage<T extends Object?>(
    PolicySummary policy,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.policyDetail,
        extra: policy,
      ),
    );
  }

  void goToPolicyDetailPage<T extends Object?>(PolicySummary policy) {
    return _go(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.policyDetail,
        extra: policy,
      ),
    );
  }

  void goToClaimsDetailsPage<T extends Object?>() {
    return _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.claims,
      ),
    );
  }

  Future<Object?> pushBillingDetailPage<T extends Object?>(
    PolicySummary policy, {
    String? location,
  }) {
    final params = {
      TfbRouterQueryParams.location: location,
    }..removeWhere((key, value) => value == null);

    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.billingDetail,
        extra: policy,
      ),
      queryParams: params,
    );
  }

  Future<Object?> pushCurrentBillPage<T extends Object?>(
    CurrentBillPageParameters currentBillPageParameters,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.viewCurrentBillPdf,
        extra: currentBillPageParameters,
      ),
    );
  }

  Future<Object?> pushMakeAPaymentDialog<T extends Object?>(
    PolicySummary policy,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.makeAPaymentDialog,
        extra: policy,
      ),
    );
  }

  Future<Object?> pushAutoPayEnrollment<T extends Object>(
    PolicySummary policy,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.autoPayEnrollment,
        extra: policy,
      ),
    );
  }

  void goToAccountUpdatedEmailVerifyPage() {
    return _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.accountVerifyUpdateEmail,
      ),
    );
  }

  void changeTabBarLocation(NavigatorRouteWithoutExtra route) {
    return _go(route);
  }

  Future<Object?> pushChangePasswordScreen<T extends Object?>() {
    return _push(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.changePassword,
      ),
    );
  }

  void goToChangePasswordSuccessPage() {
    _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.changePasswordSuccess,
      ),
    );
  }

  Future<Object?> pushAutoPayEnrollmentSuccess<T extends Object?>(
    PolicySummary policy,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.autoPayEnrollmentSuccess,
        extra: policy,
      ),
    );
  }

  Future<Object?> pushDiscontinueAutoPayEnrollment(
    PolicySummary policy,
  ) =>
      _push(
        NavigatorRouteWithExtra(
          route: TfbAppRoutes.autoPayEnrollmentDiscontinuePage,
          extra: policy,
        ),
      );

  Future<Object?> pushFileAClaimPage<T extends Object?>() {
    return _push(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.fileAClaim,
      ),
    );
  }

  void pushAppInfoPage() {
    _push(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.appInfo,
      ),
    );
  }

  Future<Object?> pushCustomerServicePage<T extends Object?>() {
    return _push(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.customerService,
      ),
    );
  }

  void goToFileAClaimHomeOwnerPage<T extends Object?>(PolicyInfo extra) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.fileAClaimHomeOwnerFilePage,
        extra: PolicyInfo(
          policySelection: extra.policySelection,
          dateOfLoss: extra.dateOfLoss,
        ),
      ),
    );
  }

  void pushFileAClaimHomeOwnerSuccessPage<T extends Object?>(
    PolicyHomeownerSuccess extra,
  ) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.fileAClaimHomeOwnerSuccessPage,
        extra: PolicyHomeownerSuccess(
          confirmationNumber: extra.confirmationNumber,
          policySelection: extra.policySelection,
          dateOfLoss: extra.dateOfLoss,
        ),
      ),
    );
  }

  void pushToAddPhotosAutoPage<T extends Object?>(ClaimSubmission extra) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.addPhotosPageAuto,
        extra: extra,
      ),
    );
  }

  void pushToAddPhotosHomeOwnerPage<T extends Object?>(ClaimSubmission extra) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.addPhotosPageHomeOwner,
        extra: extra,
      ),
    );
  }

  void goToFileAnAutoClaimPage<T extends Object?>(PolicyInfo extra) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.fileAnAutoClaimFilePage,
        extra: PolicyInfo(
          policySelection: extra.policySelection,
          dateOfLoss: extra.dateOfLoss,
        ),
      ),
    );
  }

  void pushFileAClaimPersonalAutoSuccessPage<T extends Object?>(
    PolicyAutoSuccess extra,
  ) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.fileAClaimPersonalAutoSuccessPage,
        extra: PolicyAutoSuccess(
          claimNumber: extra.claimNumber,
          policySelection: extra.policySelection,
          dateOfLoss: extra.dateOfLoss,
        ),
      ),
    );
  }

  void goToOneTimePaymentsPage<T extends Object?>(
    PolicySummary policy,
  ) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.authenticatedOneTimePayment,
        extra: policy,
      ),
    );
  }

  void pushToWebViewerPage<T extends Object?>(
    Uri uri,
  ) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.webViewerPage,
        extra: uri,
      ),
    );
  }

  Future<Object?> pushRoadsideAssistancePage<T extends Object?>() {
    return _push(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.roadsideAssistance,
      ),
    );
  }

  Future<Object?> pushPolicyDocumentPdfPage(
    PolicyDocumentPageParameters params,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.viewPolicyDocumentPdf,
        extra: params,
      ),
    );
  }

  void pushBillingDocumentPdfViewerPage(
    BillingDocumentPdfViewerPageParameters params,
  ) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.billingDocumentPdfViewer,
        extra: params,
      ),
    );
  }

  void goPdfViewerPage(PdfViewerPageParameters params) {
    return _go(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.viewInsuranceCardPdf,
        extra: params,
      ),
    );
  }

  Future<Object?> pushInsuranceCardViewerPage<T extends Object?>(
    PdfViewerPageParameters params,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.viewInsuranceCardPdf,
        extra: params,
      ),
    );
  }

  void pushInsuranceCardPage({
    required InsuranceCardPageParameters params,
  }) {
    _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.insuranceCardPage,
        extra: params,
      ),
    );
  }

  void goToPolicyListPage<T extends Object?>() {
    return _go(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.policies,
      ),
    );
  }

  Future<Object?> pushGoToSettingsDialog<T extends Object?>() {
    return _push(
      NavigatorRouteWithoutExtra(
        route: TfbAppRoutes.goToSettingsDialog,
      ),
    );
  }

  Future<Object?> pushCancelClaimsDialog<T extends Object?>(
    PolicySelection policy,
  ) {
    return _push(
      NavigatorRouteWithExtra(
        route: TfbAppRoutes.goToCancelClaimsDialog,
        extra: policy,
      ),
    );
  }
}

extension NavigationHelpersExt on BuildContext {
  TfbNavigator get navigator => read<TfbNavigator>();
// TODO: Below is a more appropriate way to get location than above
// 'location' accessor, but requires refactor of several tests.
// Dependent code should perhaps be rewritten to avoid such
// route dependence entirely.
//String get routeLocation => read<GoRouterState>().uri.toString();
}
