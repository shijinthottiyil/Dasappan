import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/constants/constants.dart';

class SettingsIconWidget extends StatelessWidget {
  const SettingsIconWidget({
    required this.icon,
    required this.color,
    super.key,
  });
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5).r,
      ),
      child: Icon(
        icon,
        color: AppColors.kWhite,
      ),
    );
  }
}
