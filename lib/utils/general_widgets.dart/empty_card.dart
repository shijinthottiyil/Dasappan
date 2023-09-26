import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_stream/utils/constants/constants.dart';

class EmptyCard extends StatelessWidget {
  final String text;
  const EmptyCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 373.w,
            height: 462.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.3),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10).r),
              border: Border.all(
                width: 0.5,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: LottieBuilder.asset('assets/lottie/empty.json'),
                ),
                Center(
                  child: Text(
                    text,
                    style: AppTypography.kExtraBold24
                        .copyWith(color: AppColors.kBlack),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
