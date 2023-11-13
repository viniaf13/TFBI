import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/plugin_haven.dart';
import 'package:txfb_insurance_flutter/app/cubits/wallet/wallet_cubit.dart';
import 'package:txfb_insurance_flutter/domain/domain.dart';
import 'package:txfb_insurance_flutter/domain/models/policy/wallet_url.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class WalletButton extends StatelessWidget {
  const WalletButton({required this.policyDetails, super.key});

  // This forces the ios native passKit to make a one line wallet image, note
  // that width/height is ignored for google card.
  static const double oneLineHeight = 30;

  static bool _initializeUrl = true;
  final AutoPolicyDetail policyDetails;

  @override
  Widget build(BuildContext context) {
    if (_initializeUrl) {
      _initializeUrl = false;
      final String url = WalletUrl().url;
      WalletCardPlatform.serviceUrl(
        newUrl: url,
      );
    }

    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletFailure) {
          context.showErrorSnackBar(
            text: context.getLocalizationOf.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await context.read<WalletCubit>().handleAddWallet(policyDetails);
          },
          // Wrap in order to put wallet image (iOS) in position that allows
          // gesture detector to work.
          child: ColoredBox(
            color: Colors.transparent,
            child: FittedBox(
              child: ConstrainedBox(
                // Give initial size as bridge to native causes a delay with
                // initial dimensions of zero
                constraints: const BoxConstraints(minWidth: 1, minHeight: 1),
                child: WalletCardPlatform.instance.getWalletIcon(
                  height: oneLineHeight,
                  width: 8 * oneLineHeight,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
