import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:txfb_insurance_flutter/device/camera/camera_file_storage.dart';
import 'package:txfb_insurance_flutter/resources/theme/colors/tfb_brand_colors.dart';
import 'package:txfb_insurance_flutter/shared/constants/spacing.dart';
import 'package:txfb_insurance_flutter/shared/constants/tfb_asset_strings.dart';
import 'package:txfb_insurance_flutter/shared/extensions/extensions.dart';

class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({
    required this.images,
    this.onRemove,
    super.key,
  });

  /// Data source for the photos to display
  final List<XFile> images;

  /// Callback function for removing images from data source.
  /// If not provided, the remove image button will not be displayed
  final void Function(XFile)? onRemove;

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: kSpacingSmall,
        runSpacing: kSpacingSmall,
        children: widget.images
            .map(
              (image) => _PictureDisplay(
                imageSource: image,
                shouldShowRemoveButton: widget.onRemove != null,
                onRemove: (XFile image) {
                  widget.onRemove!(image);
                  setState(() {});
                },
                key: Key(image.name),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PictureDisplay extends StatelessWidget {
  const _PictureDisplay({
    required this.imageSource,
    required this.shouldShowRemoveButton,
    this.onRemove,
    super.key,
  });

  final XFile imageSource;
  final bool shouldShowRemoveButton;
  final void Function(XFile)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: TfbBrandColors.grayMedium,
        borderRadius: context.radii.defaultRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: CameraFileStorage.imageFromXFile(
              imageSource,
            ),
            builder: (context, snapshot) {
              final imageWasConvertedSuccessfully =
                  snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError &&
                      snapshot.hasData;
              return Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: TfbBrandColors.white,
                  borderRadius: context.radii.defaultRadius,
                  image: imageWasConvertedSuccessfully
                      ? DecorationImage(
                          image: snapshot.data!.image,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              );
            },
          ),
          if (shouldShowRemoveButton)
            InkWell(
              onTap: () => onRemove!(imageSource),
              child: Container(
                width: 32,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: context.radii.defaultRadius,
                ),
                child: Align(
                  child: Image.asset(
                    TfbAssetStrings.closeIcon,
                    color: TfbBrandColors.grayHighest,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
