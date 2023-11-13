import 'package:txfb_insurance_flutter/app/pages/policies_list/policy_list_builder.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class PolicyListPage extends StatelessWidget {
  const PolicyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          titleString: context.getLocalizationOf.policyListPageTitle,
        ),
        body: SafeArea(
          child: TfbDropShadowScrollWidget(
            child: CustomScrollView(
              primary: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: kSpacingMedium,
                      left: kSpacingLarge,
                    ),
                    child: Text(
                      context.getLocalizationOf.policyListPageTitle,
                      style: context.tfbText.header3.copyWith(
                        color: TfbBrandColors.blueHighest,
                      ),
                    ),
                  ),
                ),
                const PolicyListBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
