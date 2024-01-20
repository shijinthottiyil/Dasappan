import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/ui/constants/app_colors.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 380.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.kRed,
          ),
        ),
        child: const Center(
          child: Icon(Icons.error_rounded),
        ),
      ),
    );
  }
}
