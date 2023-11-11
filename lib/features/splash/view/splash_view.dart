import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';

import 'package:music_stream/features/splash/view/widgets/random_text_reveal.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  // final _controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    // final c = Get.put(SplashController());
    return Scaffold(
      body: Center(
        // child: Image.asset(
        //   AppAssets.kLogo,
        //   width: 100.w,
        //   height: 100.h,
        // ),
        child: RandomTextReveal(
          randomString: Source.uppercase,
          text: 'ദാസപ്പൻ',
          // initialText: 'SAASPPNA',
          duration: const Duration(seconds: 2),
          style: const TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 36,
            fontWeight: FontWeight.w700,
            letterSpacing: 10,
          ),
          curve: Curves.linear,
          onFinished: () {
            // c.goHome();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offAll(() => BottomView());
            });
          },
        ),
      ),
    );
  }
}
