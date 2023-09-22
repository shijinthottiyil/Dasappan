import 'package:flutter/material.dart';
import 'package:music_stream/utils/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kBlack,
    appBarTheme: const AppBarTheme(
      // iconTheme: const IconThemeData(
      //   color: Colors.black,
      // ),
      // titleTextStyle: AppTypography.kBold24.copyWith(color: Colors.black),
      backgroundColor: AppColors.kBlack,
      elevation: 0,
    ),
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
    navigationBarTheme: NavigationBarThemeData(
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
