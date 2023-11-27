import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/splash/view/splash_view.dart';

import 'package:music_stream/utils/constants/constants.dart';

// Migrating to Getx
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  // SystemChrome.setSystemUIOverlayStyle(
  //   // <========== OLDER COLOR FOR MP3 CONVERTER ==================>
  //   // SystemUiOverlayStyle.dark.copyWith(
  //   //   statusBarColor: Colors.grey.shade300,
  //   //   systemNavigationBarColor: Colors.grey.shade300,
  //   // ),

  //   SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: Colors.black,
  //     systemNavigationBarColor: Colors.black,
  //   ),
  // );

  ///Initialize storage driver with await
  ///
  await GetStorage.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   // theme: ThemeData(
    //   //   fontFamily: 'Sen',
    //   //   scaffoldBackgroundColor: Colors.black,
    //   //   textTheme: Theme.of(context).textTheme.apply(
    //   //         bodyColor: Colors.white,
    //   //         displayColor: Colors.white,
    //   //       ),
    //   // ),
    //   theme: ThemeData.dark().copyWith(
    //     useMaterial3: true,
    //     scaffoldBackgroundColor: Colors.black,
    //     appBarTheme: AppBarTheme(
    //       elevation: 0,
    //       backgroundColor: Colors.black,
    //     ),
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: const HomePage(),
    // );

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme.copyWith(
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: AppColors.kWhite,
                  displayColor: AppColors.kWhite,
                ),
          ),
          scrollBehavior: const ScrollBehavior()
              .copyWith(physics: const BouncingScrollPhysics()),
          defaultTransition: Transition.fadeIn,
          home: child,
        );
      },
      child: const SplashView(),
    );
  }
}
