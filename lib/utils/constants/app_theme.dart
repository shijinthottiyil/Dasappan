/*
import 'package:flutter/material.dart';
import 'package:music_stream/utils/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
    // scaffoldBackgroundColor: AppColors.kBlack,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      // iconTheme: const IconThemeData(
      //   color: Colors.black,
      // ),
      // titleTextStyle: AppTypography.kBold24.copyWith(color: Colors.black),
      // backgroundColor: AppColors.kBlack,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: AppColors.kWhite),
    // tabBarTheme: TabBarTheme(
    //   labelPadding: EdgeInsets.only(
    //     left: 10,
    //     right: AppSpacing.tenHorizontal,
    //   ),
    //   indicatorSize: TabBarIndicatorSize.label,
    //   labelStyle: AppTypography.kBold20,
    //   labelColor: AppColors.kSecondary,
    //   unselectedLabelColor: AppColors.kLightBrown,
    // ),
    fontFamily: 'Inter',
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: EdgeInsets.symmetric(
    //     horizontal: AppSpacing.twentyHorizontal,
    //     vertical: 16.h,
    //   ),
    //   enabledBorder: const OutlineInputBorder(
    //     borderSide: BorderSide.none,
    //   ),
    //   focusedBorder: const OutlineInputBorder(
    //     borderSide: BorderSide.none,
    //   ),
    //   border: const OutlineInputBorder(
    //     borderSide: BorderSide.none,
    //   ),
    //   errorBorder: const OutlineInputBorder(
    //     borderSide: BorderSide.none,
    //   ),
    // ),
    navigationBarTheme: const NavigationBarThemeData(
      // type: BottomNavigationBarType.fixed,
      // backgroundColor: AppColors.kBrown,
      // elevation: 0,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      backgroundColor: AppColors.kBrown,
      elevation: 0,
      indicatorColor: AppColors.kRed,

      // indicatorShape: RoundedRectangleBorder(),
    ),
  );
}
*/

import 'package:flutter/material.dart';
import 'package:music_stream/utils/constants/app_texts.dart';

///Trying out Dynamic Theme Switching.[Means change the app theme according to the System Settings].
///
class AppTheme {
  //Light Theme.
  static ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    // primaryColor: Colors.red,
    brightness: Brightness.light,

    // scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
    fontFamily: AppTexts.kFontFamily,
  );

  //Dark Theme.
  static ThemeData darkThemd = ThemeData(
    // useMaterial3: true,
    // primarySwatch: Colors.teal,
    brightness: Brightness.dark,

    // scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    fontFamily: AppTexts.kFontFamily,
  );
}
