import 'package:flutter/material.dart';

///Trying out Dynamic Theme Switching.[Means change the app theme according to the System Settings].
///
class AppTheme {
  //Light Theme.
  static ThemeData lightTheme = ThemeData(
      // useMaterial3: true,
      // primaryColor: Colors.red,
      brightness: Brightness.light,
      scrollbarTheme: const ScrollbarThemeData(
        interactive: true,
        thickness: MaterialStatePropertyAll(8.0),
        radius: Radius.circular(8.0),
      )

      // scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
      // fontFamily: AppTexts.kFontFamily,
      // textTheme: GoogleFonts.openSansTextTheme(),
      );

  //Dark Theme.
  static ThemeData darkTheme = ThemeData(
      // useMaterial3: true,
      // primarySwatch: Colors.teal,
      brightness: Brightness.dark,
      scrollbarTheme: const ScrollbarThemeData(
        interactive: true,
        thickness: MaterialStatePropertyAll(8.0),
        radius: Radius.circular(8.0),
      )

      // scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      // fontFamily: AppTexts.kFontFamily,
      );
}
