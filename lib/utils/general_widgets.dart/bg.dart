import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_stream/utils/constants/app_assets.dart';

class Bg extends StatelessWidget {
  const Bg({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 100,
            sigmaY: 100,
          ),
          child: Image.asset(
            AppAssets.kLenin,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
