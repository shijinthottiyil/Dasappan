import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:music_stream/features/home/controller/home_controller.dart';

import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/general_widgets.dart/bg.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  final homeC = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _pulseController.repeat(reverse: true);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   homeC.getQuickpicks(isSplash: true);
    // });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Bg(
      child: Scaffold(
        body: Center(
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
              parent: _pulseController,
              curve: Curves.linear,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTexts.kTitleEng,
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: AppColors.kWhite,
                  ),
                ),
                Text(
                  AppTexts.kIntro,
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: AppColors.kWhite,
                  ),
                ),
              ],
            ),
            // child: Text(
            //   AppTexts.kIntro,
            //   style: AppTypography.kExtraBold24
            //       .copyWith(color: AppColors.kBlack),
            // ),
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // Pulse animation for the image
          //     FadeTransition(
          //       opacity:
          //           Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          //         parent: _pulseController,
          //         curve: Curves.linear,
          //       )),
          //       child: Container(
          //         // borderRadius: BorderRadius.circular(20).r,
          //         width: 150.w,
          //         height: 150.w,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           image: DecorationImage(
          //             image: AssetImage(AppAssets.kLenin),
          //           ),
          //         ),
          //         // child: Image.asset(
          //         //   AppAssets.kLenin,
          //         //   // width: 200.w,
          //         //   // height: 200.w,
          //         // ),
          //       ),
          //     ),
          //     AppSpacing.gapH12,
          //     // Pulse animation for the text
          //     FadeTransition(
          //       opacity:
          //           Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          //         parent: _pulseController,
          //         curve: Curves.linear,
          //       )),
          //       child: Text(
          //         AppTexts.kIntro,
          //         style: TextStyle(
          //           fontFamily: 'Orbitron',
          //           fontSize: 24.sp,
          //           fontWeight: FontWeight.w700,
          //           letterSpacing: 2,
          //           color: AppColors.kWhite,
          //         ),
          //       ),
          //       // child: Text(
          //       //   AppTexts.kIntro,
          //       //   style: AppTypography.kExtraBold24
          //       //       .copyWith(color: AppColors.kBlack),
          //       // ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
