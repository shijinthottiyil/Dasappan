import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/utils/constants/constants.dart';
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
    await Get.dialog(
      WillPopScope(
        child: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColors.kWhite,
            size: 50.r,
          ),
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
