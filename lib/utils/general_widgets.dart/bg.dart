import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/utils/constants/app_assets.dart';

class Bg extends StatelessWidget {
  const Bg({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: FadeInImage(
            placeholder: AssetImage(
              AppAssets.kBg,
            ),
            image: NetworkImage(
              homeC.home.wallpaperModel.value.urls?.full ?? '',
            ),
            imageErrorBuilder: (context, error, stackTrace) => Image.asset(
              AppAssets.kBg,
              // width: 48.w,
              // height: 48.w,
              fit: BoxFit.cover,
            ),
            // width: 48.w,
            // height: 48.w,
            fit: BoxFit.fill,
            placeholderFit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
