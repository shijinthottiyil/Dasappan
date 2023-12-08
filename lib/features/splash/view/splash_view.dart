import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:music_stream/features/home/controller/home_controller.dart';

import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/general_widgets.dart/bg.dart';

///Trying out autoScrollable Splash Screen.
///
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({Key? key}) : super(key: key);

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _pulseController;
//   final homeC = Get.put(HomeController());

//   @override
//   void initState() {
//     super.initState();

//     _pulseController = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );

//     _pulseController.repeat(reverse: true);

//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   homeC.getQuickpicks(isSplash: true);
//     // });
//   }

//   @override
//   void dispose() {
//     _pulseController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Bg(
//       child: Scaffold(
//         body: Center(
//           child: FadeTransition(
//             opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//               parent: _pulseController,
//               curve: Curves.linear,
//             )),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   AppTexts.kTitleEng,
//                   style: TextStyle(
//                     fontFamily: 'Orbitron',
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 2,
//                     color: AppColors.kWhite,
//                   ),
//                 ),
//                 Text(
//                   AppTexts.kIntro,
//                   style: TextStyle(
//                     fontFamily: 'Orbitron',
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 2,
//                     color: AppColors.kWhite,
//                   ),
//                 ),
//               ],
//             ),
//             // child: Text(
//             //   AppTexts.kIntro,
//             //   style: AppTypography.kExtraBold24
//             //       .copyWith(color: AppColors.kBlack),
//             // ),
//           ),

//           // Column(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: [
//           //     // Pulse animation for the image
//           //     FadeTransition(
//           //       opacity:
//           //           Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//           //         parent: _pulseController,
//           //         curve: Curves.linear,
//           //       )),
//           //       child: Container(
//           //         // borderRadius: BorderRadius.circular(20).r,
//           //         width: 150.w,
//           //         height: 150.w,
//           //         decoration: BoxDecoration(
//           //           shape: BoxShape.circle,
//           //           image: DecorationImage(
//           //             image: AssetImage(AppAssets.kLenin),
//           //           ),
//           //         ),
//           //         // child: Image.asset(
//           //         //   AppAssets.kLenin,
//           //         //   // width: 200.w,
//           //         //   // height: 200.w,
//           //         // ),
//           //       ),
//           //     ),
//           //     AppSpacing.gapH12,
//           //     // Pulse animation for the text
//           //     FadeTransition(
//           //       opacity:
//           //           Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//           //         parent: _pulseController,
//           //         curve: Curves.linear,
//           //       )),
//           //       child: Text(
//           //         AppTexts.kIntro,
//           //         style: TextStyle(
//           //           fontFamily: 'Orbitron',
//           //           fontSize: 24.sp,
//           //           fontWeight: FontWeight.w700,
//           //           letterSpacing: 2,
//           //           color: AppColors.kWhite,
//           //         ),
//           //       ),
//           //       // child: Text(
//           //       //   AppTexts.kIntro,
//           //       //   style: AppTypography.kExtraBold24
//           //       //       .copyWith(color: AppColors.kBlack),
//           //       // ),
//           //     ),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }

///Trying out AutoScrolling splash Screen.
///
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ///List that contains the images to be displayed in the screen.
  final _imageList = [
    AppAssets.kArjit,
    AppAssets.kAnimal,
    AppAssets.kChitra,
    AppAssets.kJimikki,
    AppAssets.kShreya,
    AppAssets.kMalare,
    AppAssets.kVijayYesudas,
    AppAssets.kMukkathePenne,
    // AppAssets.kYesudas,
    AppAssets.kRanam,
    AppAssets.kWeekend,
    AppAssets.kPoovi,
    AppAssets.kMg,
  ];

  ///ScrollController for enabling automatic scrolling.
  ///
  final _scrollController = ScrollController();

  ///Enabling the autoScroll fuctionality inside initState.
  ///
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: _imageList.length * 5),
          curve: Curves.linear,
        );
      },
    );
  }

  ///Disposing the Scroll Controller.
  ///
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AbsorbPointer(
            child: GridView.custom(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              gridDelegate: SliverWovenGridDelegate.count(
                pattern: [
                  WovenGridTile(1),
                  WovenGridTile(
                    5 / 7,
                    crossAxisRatio: 0.9,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ],
                crossAxisCount: 2,
                // mainAxisSpacing: 2,
                // crossAxisSpacing: 2,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: _imageList.length,
                (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image(
                      image: AssetImage(_imageList[index]),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.5),
                  width: double.infinity,
                  height: 300.h,
                  child: Text(
                    AppTexts.kTitleEng,
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: AppColors.kBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0038318, size.height * 1.0033333);
    path_0.lineTo(0, 0);
    path_0.quadraticBezierTo(size.width * 0.3192757, size.height * 0.2122333,
        size.width * 0.4799065, size.height * 0.1976667);
    path_0.quadraticBezierTo(
        size.width * 0.6982477, size.height * 0.2069000, size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width * -0.0038318, size.height * 1.0033333);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
