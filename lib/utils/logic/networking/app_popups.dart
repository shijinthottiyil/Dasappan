import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppPopups {
  static void errorSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.kRed200,
    );
  }

  static void infoSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
    );
  }

  static void successSnackbar(
      {required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.kGreen,
    );
  }

  // Loader
  static Future<void> showDialog() async {
    const color = AppColors.kWhite;
    final size = 50.r;
// Define all your loading animations here
    var loadingAnimationsList = [
      LoadingAnimationWidget.beat(color: color, size: size),
      LoadingAnimationWidget.bouncingBall(color: color, size: size),
      LoadingAnimationWidget.discreteCircle(color: color, size: size),
      LoadingAnimationWidget.dotsTriangle(color: color, size: size),
      LoadingAnimationWidget.fallingDot(color: color, size: size),
      LoadingAnimationWidget.halfTriangleDot(color: color, size: size),
      LoadingAnimationWidget.hexagonDots(color: color, size: size),
      LoadingAnimationWidget.horizontalRotatingDots(color: color, size: size),
      LoadingAnimationWidget.inkDrop(color: color, size: size),
      LoadingAnimationWidget.newtonCradle(color: color, size: size),
      LoadingAnimationWidget.prograssiveDots(color: color, size: size),
      LoadingAnimationWidget.staggeredDotsWave(color: color, size: size),
      LoadingAnimationWidget.stretchedDots(color: color, size: size),
      LoadingAnimationWidget.threeArchedCircle(color: color, size: size),
      LoadingAnimationWidget.threeRotatingDots(color: color, size: size),
      LoadingAnimationWidget.twoRotatingArc(color: color, size: size),
      LoadingAnimationWidget.waveDots(color: color, size: size),
    ];

    // Randomly choose a loading animation
    final random = Random();
    final randomLoadingAnimation =
        loadingAnimationsList[random.nextInt(loadingAnimationsList.length)];

    await Get.dialog(
      WillPopScope(
        child: Center(
          child: randomLoadingAnimation,
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: true,
      barrierColor: AppColors.kBlack.withOpacity(0.3),
      useSafeArea: true,
    );
  }

  // Cancel Loader
  static void cancelDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
