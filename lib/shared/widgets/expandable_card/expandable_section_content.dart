import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

class ExpandableSectionContent extends StatefulWidget {
  const ExpandableSectionContent({
    required this.title,
    required this.children,
    this.tilePadding,
    this.childrenPadding,
    this.iconColor,
    super.key,
  });

  final Text title;
  final List<Widget> children;
  final EdgeInsets? tilePadding;
  final EdgeInsets? childrenPadding;
  final Color? iconColor;

  @override
  State<StatefulWidget> createState() => _ExpandableSectionContentState();
}

class _ExpandableSectionContentState extends State<ExpandableSectionContent>
    with SingleTickerProviderStateMixin {
  bool _tileExpanded = false;
  late AnimationController _expansionController;

  @override
  void initState() {
    super.initState();
    _expansionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void handleExpansionTap({required bool expanded}) {
    setState(() {
      _tileExpanded
          ? _expansionController.reverse()
          : _expansionController.forward();
      _tileExpanded = expanded;
      if (expanded) {
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
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 24),
        listTileTheme: const ListTileThemeData(
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
      ),
      child: Semantics(
        container: true,
        explicitChildNodes: true,
        child: ExpansionTile(
          title: Semantics(
            onTapHint: context.getLocalizationOf.expandableSemanticHint,
            child: widget.title,
          ),
          trailing: ExpandCardIcon(
            controller: _expansionController,
            color: widget.iconColor,
          ),
          collapsedBackgroundColor: TfbBrandColors.blueLowest,
          backgroundColor: TfbBrandColors.blueLowest,
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding: widget.tilePadding ??
              const EdgeInsets.only(
                bottom: kSpacingExtraSmall,
                right: kSpacingMedium,
                left: kSpacingMedium,
              ),
          childrenPadding: widget.childrenPadding ??
              const EdgeInsets.only(
                bottom: kSpacingMedium,
                left: kSpacingMedium,
                right: kSpacingMedium,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: context.radii.defaultRadiusBottom,
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: context.radii.defaultRadiusBottom,
          ),
          onExpansionChanged: (bool expanded) =>
              handleExpansionTap(expanded: expanded),
          children: widget.children,
        ),
      ),
    );
  }
}
