import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/update_email/update_email_cubit.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/update_email_form_container.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/account_list_tiles.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/communication_preferences.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/contact_list.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/contacts_error_bloc_listener.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/my_account_page_title.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/paperless_notification_preferences.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/widgets/no_splash_theme_provider.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          titleString: context.getLocalizationOf.myAccountPageTitle,
        ),
        body: TfbDropShadowScrollWidget(
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kSpacingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactsErrorBlocListener(),
                    MyAccountPageTitle(),
                    CommunicationPreferences(),
                    ContactList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kSpacingSmall,
                  right: kSpacingSmall,
                  top: kSpacingLarge,
                ),
                child: BlocProvider(
                  create: (context) => UpdateEmailCubit(),
                  child: const UpdateEmailFormContainer(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacingLarge),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kSpacingXxl,
                        bottom: kSpacingLarge,
                      ),
                      child: PaperlessNotificationPreferences(
                        preferencesCopy:
                            context.getLocalizationOf.preferencesDirection,
                      ),
                    ),
                    const NoSplashThemeProvider(child: AccountListTiles()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
