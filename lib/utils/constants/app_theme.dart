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
