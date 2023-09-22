import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_stream/controller/home_controller.dart';
import 'package:music_stream/old%20feature/home/view/home_page.dart';
import 'package:music_stream/features/splash/view/splash_view.dart';
import 'package:music_stream/utils/constants/constants.dart';

import 'package:music_stream/view/home/home_screen.dart';
import 'package:music_stream/view/search/search_screen.dart';
import 'package:music_stream/view/tabbar/tabbar_screen.dart';

// Migrating to Getx
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    // <========== OLDER COLOR FOR MP3 CONVERTER ==================>
    // SystemUiOverlayStyle.dark.copyWith(
    //   statusBarColor: Colors.grey.shade300,
    //   systemNavigationBarColor: Colors.grey.shade300,
    // ),

    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
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
      child: SplashView(),
    );
  }
}
