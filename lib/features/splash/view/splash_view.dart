import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/splash/view/widgets/random_text_reveal.dart';
import 'package:music_stream/utils/constants/app_assets.dart';
import 'package:music_stream/utils/constants/app_spacing.dart';
import 'package:music_stream/utils/general_widgets.dart/bg.dart';
import 'package:music_stream/utils/networking/connection_controller.dart';

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
      duration: Duration(seconds: 1),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pulse animation for the image
              FadeTransition(
                opacity:
                    Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _pulseController,
                  curve: Curves.linear,
                )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20).r,
                  child: Image.asset(
                    AppAssets.kLenin,
                    width: 200.w,
                    height: 200.w,
                  ),
                ),
              ),
              AppSpacing.gapH12,
              // Pulse animation for the text
              FadeTransition(
                opacity:
                    Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _pulseController,
                  curve: Curves.linear,
                )),
                child: Text(
                  'DASAPPAN',
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
