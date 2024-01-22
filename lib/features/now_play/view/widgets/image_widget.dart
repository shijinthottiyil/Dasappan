import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: FadeInImage(
        placeholder: AssetImage(
          AppAssets.kLenin,
        ),
        image: NetworkImage(url ?? AppAssets.kNetworkImage),
        imageErrorBuilder: (context, error, stackTrace) => Image.asset(
          AppAssets.kLenin,
          width: double.infinity,
          height: 380.w,
          fit: BoxFit.fill,
        ),
        width: double.infinity,
        height: 380.w,
        fit: BoxFit.fill,
        placeholderFit: BoxFit.fill,
      ),
    );
  }
}
