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
            sigmaX: 1,
            sigmaY: 1,
          ),
          child: Image.asset(
            AppAssets.kBg,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
