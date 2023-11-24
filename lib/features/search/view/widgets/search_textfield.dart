import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/constants/constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.placeholder,
    required this.onSubmitted,
  });
  final String? placeholder;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField.borderless(
      padding: EdgeInsets.all(15.r),
      prefix: Padding(
        padding: EdgeInsets.only(left: 15.r),
        child: const Icon(
          Icons.search_rounded,
          color: AppColors.kBrown75,
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
