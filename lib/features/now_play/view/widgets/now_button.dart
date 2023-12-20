import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NowButton extends StatelessWidget {
  const NowButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 0,
  });
  final IconData? icon;
  final void Function()? onPressed;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onPressed,
      icon: Icon(
        icon,
        // color: AppColors.kWhite,
        size: size == 0 ? 56.h : size,
      ),
    );
  }
}
