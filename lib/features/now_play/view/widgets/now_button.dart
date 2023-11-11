import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/constants/constants.dart';

class NowButton extends StatelessWidget {
  const NowButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final IconData? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.kWhite,
        size: 56.h,
      ),
    );
  }
}
