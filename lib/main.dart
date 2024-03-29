import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/splash/view/splash_view.dart';
import 'package:music_stream/utils/logic/bindings/all_controller_bindings.dart';
import 'package:music_stream/utils/logic/database/database_manager.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

// Migrating to Getx
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.initializeDatabase();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
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
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AllControllerBindings(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
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
