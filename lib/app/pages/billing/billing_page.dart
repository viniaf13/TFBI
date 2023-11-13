import 'package:txfb_insurance_flutter/app/pages/billing/widgets/billing_member_summary_consumer.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/mixins/page_properties_mixin.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_animated_app_bar.dart';
import 'package:txfb_insurance_flutter/shared/widgets/tfb_dropshadow_scroll_widget.dart';

class BillingPage extends StatelessWidget with PagePropertiesMixin {
  const BillingPage({super.key});

  @override
  String get screenName => 'Billing';

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: TfbAnimatedAppBar(
          titleString: context.getLocalizationOf.billingTitle,
        ),
        body: TfbDropShadowScrollWidget(
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
                    context.getLocalizationOf.billingTitle,
                    style: context.tfbText.header3.copyWith(
                      color: TfbBrandColors.blueHighest,
                    ),
                  ),
                ),
              ),
              const BillingMemberSummaryConsumer(),
            ],
          ),
        ),
      ),
    );
  }
}
