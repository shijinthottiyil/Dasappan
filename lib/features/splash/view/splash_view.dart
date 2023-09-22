import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/splash/controller/splash_controller.dart';
import 'package:music_stream/utils/constants/app_assets.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  final _controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.kLogo,
          width: 100.w,
          height: 100.h,
        ),
      ),
    );
  }
}
