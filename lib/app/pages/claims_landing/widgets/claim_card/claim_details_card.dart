import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/pages/claims_landing/widgets/claim_details_widgets.dart';
import 'package:txfb_insurance_flutter/app/router/tfb_routes.dart';
import 'package:txfb_insurance_flutter/domain/models/claims/domain_models/full_claim.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/colors.dart';
import 'package:txfb_insurance_flutter/shared/utils/tab_tap_notifier.dart';
import 'package:txfb_insurance_flutter/texas_farm_bureau_insurance.dart';

class ClaimDetailsCard extends StatefulWidget {
  const ClaimDetailsCard({
    required this.claim,
    super.key,
  });

  final FullClaim claim;

  @override
  State<ClaimDetailsCard> createState() => _ClaimDetailsCardState();
}

class _ClaimDetailsCardState extends State<ClaimDetailsCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  TabTapNotifier? tabTapNotifier;
  final animationDuration = const Duration(milliseconds: 400);

  void listenForBottomNavTap() {
    if (isExpanded && tabTapNotifier?.value == TfbAppRoutes.claims) {
      handleExpansionTap();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    tabTapNotifier = context.read<TabTapNotifier>();
    tabTapNotifier?.addListener(listenForBottomNavTap);
  }

  void handleExpansionTap() {
    setState(() {
      isExpanded ? _controller.reverse() : _controller.forward();
      isExpanded = !isExpanded;
      if (isExpanded) {
        _scrollToSelectedContent();
      }
    });
  }

  void _scrollToSelectedContent() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await Scrollable.ensureVisible(
        alignment: 0.5,
        context,
        duration: const Duration(milliseconds: 800),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: kSpacingMedium),
      shape: RoundedRectangleBorder(borderRadius: context.radii.defaultRadius),
      color: TfbBrandColors.blueLowest,
      elevation: 0,
      semanticContainer: false,
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: animationDuration,
        reverseDuration: animationDuration,
        child: Column(
          children: [
            ClaimDetailsCardHeader(
              policyType: widget.claim.policyType,
              claimStatus: widget.claim.statusEnum,
              claimNumber: '#${widget.claim.claimNumber}',
              claimIcon: widget.claim.policyType!.policyTypeIcon(),
            ),
            Semantics(
              label: context.getLocalizationOf.details,
              button: true,
              child: GestureDetector(
                onTap: handleExpansionTap,
                behavior: HitTestBehavior.opaque,
                child: ClaimDetailsExpandIconRow(
                  expandIcon: ExpandCardIcon(
                    controller: _controller,
                    onTap: handleExpansionTap,
                  ),
                ),
              ),
            ),
            if (isExpanded)
              ClaimDetailsContent(
                claim: widget.claim,
                photosList: const [],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabTapNotifier?.removeListener(listenForBottomNavTap);
    super.dispose();
  }
}
