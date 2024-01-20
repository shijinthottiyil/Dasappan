// Trying out a Very minimal Splash Screen.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    ///Don't delete this code you may need this code for switching between themes baseed on system settings.
    /* var platformBrightness = MediaQuery.platformBrightnessOf(context);
    var color = platformBrightness == Brightness.light
        ? AppColors.kBlack
        : AppColors.kWhite;
        */
    // -------------------------------------------------------------------------------------------------
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Center(
            child: Image.asset(
              AppAssets.kLenin,
              width: 150.w,
              height: 150.w,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ],
      ),
    );
  }
}
