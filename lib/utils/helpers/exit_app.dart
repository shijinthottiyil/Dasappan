import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/constants/app_typography.dart';

Future<bool> exitApp() async {
  await Get.dialog(BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: AppColors.kWhite,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 32.h)
                    .copyWith(bottom: 0.h),
                child: Text(
                  'ശരിക്കും പോവാണോ ?',
                  textAlign: TextAlign.center,
                  style: AppTypography.kBold16.copyWith(
                      color: AppColors.kBrown500,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 34.w,
                ),
                child: Text(
                  'ദാസപ്പൻ ഓഫ് ആവുംട്ടാ ',
                  style: AppTypography.kMedium14.copyWith(
                      color: AppColors.kBrown400,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            SizedBox(
              height: 36.h,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                  width: 140.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.kRed,
                    borderRadius: BorderRadius.circular(20).r,
                  ),
                  child: Center(
                      child: Text(
                    "വേണ്ട",
                    style: AppTypography.kMedium14,
                  ))),
            ),
            SizedBox(
              height: 24.h,
            ),
            InkWell(
              onTap: () {
                SystemNavigator.pop();
              },
              child: Text(
                "പോട്ടെ",
                style:
                    AppTypography.kMedium14.copyWith(color: AppColors.kBlack),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    ),
  ));
  return false;
}
