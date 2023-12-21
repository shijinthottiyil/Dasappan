// Trying out a Very minimal Splash Screen.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/networking/connection_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final connectionC = Get.put(ConnectionController());
    final homeC = Get.put(HomeController());
    var platformBrightness = MediaQuery.platformBrightnessOf(context);
    var color = platformBrightness == Brightness.light
        ? AppColors.kBlack
        : AppColors.kWhite;
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.waveDots(color: color, size: 50.w),
      ),
    );
  }
}
