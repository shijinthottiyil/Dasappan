import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 380.w,
        decoration: BoxDecoration(
          border: Border.all(
            /* color: Colors.red,*/
            color: Colors.transparent,
          ),
        ),
        child: const Center(
          child: Icon(Icons.error_rounded),
        ),
      ),
    );
  }
}
