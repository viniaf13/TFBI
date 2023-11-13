import 'package:provider/provider.dart';
import 'package:txfb_insurance_flutter/app/analytics/analytics.dart';
import 'package:txfb_insurance_flutter/shared/widgets/list_tile_with_arrow.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/delete_account_list_tile.dart';
import 'package:txfb_insurance_flutter/app/pages/account/widgets/logout_confirmation_modal.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_navigator.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class AccountListTiles extends StatelessWidget {
  const AccountListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ListTile.divideTiles(
        color: TfbBrandColors.grayMedium,
        context: context,
        tiles: [
          ListTileWithArrow(
            title: context.getLocalizationOf.myAccountChangePasswordCTA,
            onPress: () {
              context.navigator.pushChangePasswordScreen();
            },
          ),
          ListTileWithArrow(
            title: context.getLocalizationOf.myAccountAppInfoCTA,
            onPress: () {
              context.navigator.pushAppInfoPage();
            },
          ),
          ListTileWithArrow(
            title: context.getLocalizationOf.myAccountLogoutCTA,
            onPress: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  TfbAnalytics.instance.track(const LogOutModalViewEvent());

                  return Provider.value(
                    value: context.read<TfbNavigator>(),
                    child: const LogoutConfirmationDialog(),
                  );
                },
              );
            },
            showArrow: false,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacingLarge),
            child: DeleteAccountListTile(),
          ),
        ],
      ).toList(),
    );
  }
}
