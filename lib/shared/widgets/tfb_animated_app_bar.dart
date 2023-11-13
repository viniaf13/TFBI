import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:txfb_insurance_flutter/app/cubits/status_bar_scroll/cubit/status_bar_scroll_cubit.dart';
import 'package:txfb_insurance_flutter/app/router/router.dart';
import 'package:txfb_insurance_flutter/resources/theme/theme.dart';
import 'package:txfb_insurance_flutter/shared/shared.dart';

/// App bar that automatically animates the title into the center of the AppBar
/// when the user scrolls.
///
/// Use in conjunction with TfbDropShadowScrollWidget to create an animated,
/// elevated AppBar effect.
class TfbAnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TfbAnimatedAppBar({
    this.showCancelButton = false,
    this.onCancelPressed,
    this.showBackButton = false,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.titleString,
    this.title,
    super.key,
  });

  final bool showCancelButton;
  final bool automaticallyImplyLeading;
  final VoidCallback? onCancelPressed;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final String? titleString;
  final Widget? title;

  @override
  State<TfbAnimatedAppBar> createState() => _TfbAnimatedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TfbAnimatedAppBarState extends State<TfbAnimatedAppBar> {
  ScrollController? _scrollController;
  ValueNotifier<bool> shouldShowNotifier = ValueNotifier(false);
  String currentRelativePath = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTitle());

    assert(
      widget.title == null || widget.titleString == null,
      'You cannot set title and titleString, choose one or the other',
    );

    if (widget.showCancelButton == true) {
      assert(
        widget.actions == null,
        'If showCancelButton is enabled, you cannot provide custom actions to the app bar',
      );
    }

    if (widget.showBackButton == true) {
      assert(
        widget.leading == null,
        'If showBackButton is enabled, you cannot provide a custom leading widget',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentRelativePath.isEmpty) {
      currentRelativePath = context.navigator.currentRelativePath;
    }
    _scrollController = PrimaryScrollController.of(context);
    _scrollController!.addListener(_updateTitle);
    final leading = widget.showBackButton
        ? IconButton(
            onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
            padding: const EdgeInsets.all(kSpacingMedium),
            icon: Image.asset(
              TfbAssetStrings.appBarBackButtonArrow,
              color: TfbBrandColors.blueHighest,
              excludeFromSemantics: true,
            ),
            style: const ButtonStyle(
              splashFactory: NoSplash.splashFactory,
            ),
            tooltip: context.getLocalizationOf.goBackToThePreviousScreen,
          )
        : null;

    final actions = widget.actions ??
        (widget.showCancelButton
            ? [
                CancelAppBarAction(
                  onPress: widget.onCancelPressed,
                ),
              ]
            : null);

    final systemOverlayStyle = widget.systemOverlayStyle ??
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        );

    final backgroundColor = widget.backgroundColor ?? Colors.transparent;

    final title = widget.title ??
        (widget.titleString != null
            ? Text(
                widget.titleString!,
                style: context.tfbText.bodyLightLarge
                    .copyWith(color: TfbBrandColors.blueHighest),
              )
            : null);

    return BlocListener<StatusBarScrollCubit, StatusBarScrollState>(
      listener: (context, state) {
        if (state is StatusBarScrollActive &&
            state.pathOfScreenTapped == currentRelativePath) {
          _scrollController!.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          context
              .read<StatusBarScrollCubit>()
              .resetScrollNotification(currentRelativePath);
        }
      },
      child: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: leading,
        actions: actions,
        systemOverlayStyle: systemOverlayStyle,
        centerTitle: true,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        title: ValueListenableBuilder(
          valueListenable: shouldShowNotifier,
          builder: (context, state, child) {
            return Padding(
              padding: const EdgeInsets.all(kSpacingSmall),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: state ? 1.0 : 0.0,
                child: title,
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateTitle() {
    if (_scrollController != null) {
      bool show = false;

      if (_scrollController!.hasClients) {
        show = _scrollController!.position.pixels > 0 && !show;
      }
      if (shouldShowNotifier.value != show) {
        shouldShowNotifier.value = show;
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_updateTitle);
    super.dispose();
  }
}
