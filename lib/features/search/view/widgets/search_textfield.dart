import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/exit_app.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.placeholder,
    required this.onSubmitted,
    required this.suffix,
  });
  final String? placeholder;
  final void Function(String)? onSubmitted;
  final Widget? suffix;
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
      suffix: suffix,
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
