import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.onSubmitted,
    required this.onTap,
  });
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      // margin: EdgeInsets.symmetric(horizontal: 16.r),
      margin: EdgeInsets.only(right: 16.r),
      decoration: BoxDecoration(
        color: AppColors.kBrown.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Type Here.'),
              style: Theme.of(context).textTheme.titleLarge,
              onSubmitted: onSubmitted,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.mic_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
