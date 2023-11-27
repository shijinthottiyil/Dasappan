import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:music_stream/utils/constants/constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.placeholder,
    required this.onSubmitted,
    required this.onTap,
  });
  final String? placeholder;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField.borderless(
      padding: EdgeInsets.all(15.r),
      prefix: Padding(
        padding: EdgeInsets.only(left: 15.r),
        child: const Icon(
          Icons.search_rounded,
          color: AppColors.kWhite,
        ),
      ),
      suffix: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(right: 15.r),
          child: Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: AppColors.kBlack,
              borderRadius: BorderRadius.circular(5).r,
            ),
            child: Icon(
              size: 20.w,
              Icons.mic_rounded,
            ),
          ),
        ),
      ),
      placeholder: placeholder,
      placeholderStyle:
          AppTypography.kMedium14.copyWith(color: AppColors.kBrown),
      style: AppTypography.kRegular13.copyWith(color: AppColors.kBrown),
      // placeholderStyle: AppTypography.kMedium14,
      // style: AppTypography.kRegular13,
      decoration: BoxDecoration(
        color: AppColors.kBrown400,
        borderRadius: BorderRadius.circular(8).r,
        backgroundBlendMode: BlendMode.colorDodge,
      ),
      onSubmitted: onSubmitted,
    );
  }
}
