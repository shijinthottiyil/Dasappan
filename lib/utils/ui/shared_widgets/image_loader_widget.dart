import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoaderWidget extends StatelessWidget {
  const ImageLoaderWidget({
    super.key,
    this.borderRadius = BorderRadius.zero,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.contain,
  });

  ///Customizing the Border Radius of the Image Being shown.
  final BorderRadiusGeometry borderRadius;

  ///Url of the image.
  final String imageUrl;

  ///Width of the Image
  final double? width;

  ///Height of the Image
  final double? height;

  ///fit:Adjusting the Fit of the image.
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            double progress = downloadProgress.progress ?? 0.0;
            return Center(
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 2.0,
              ),
            );
          },
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
          width: width,
          height: height,
          fit: fit,
        )
        // Old Code at the time of Fade in image.
        /*FadeInImage(
        placeholder: const AssetImage(AppAssets.kSlide),
        image: NetworkImage(imageUrl ?? ''),
        imageErrorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error),
        fit: BoxFit.cover,
        width: 327.w,
        // height: 152.h,
      ),
      */
        );
  }
}
