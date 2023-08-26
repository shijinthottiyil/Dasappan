import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_stream/view/home/home_screen.dart';
import 'package:music_stream/view/search_screen.dart';

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
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Sen',
      ),
      debugShowCheckedModeBanner: false,
      home: const SearchScreen(),
    );
  }
}
