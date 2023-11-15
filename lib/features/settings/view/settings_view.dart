import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/settings/view/theme_view.dart';
import 'package:music_stream/features/settings/view/widgets/color_icon.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/constants/app_typography.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTypography.kSemiBold32,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.kBrown50.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.r),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.kWhite,
                ),
                hintText: 'Search Settings',
                hintStyle: AppTypography.kMedium18
                    .copyWith(color: AppColors.kWhite.withOpacity(0.8)),
              ),
            ),
          ),
          // ListTile(
          //   leading: const ColorIcon(
          //       icon: Iconsax.timer, color: AppColors.kBrown100),
          //   title: Text(
          //     'Sleep Timer',
          //     style: AppTypography.kBold16.copyWith(letterSpacing: 1),
          //   ),
          // ),
          // ListTile(
          //   leading: const ColorIcon(
          //       icon: Iconsax.color_swatch, color: AppColors.kRed100),
          //   title: Text(
          //     'Theme',
          //     style: AppTypography.kBold16.copyWith(letterSpacing: 1),
          //   ),
          //   trailing: const Icon(
          //     EvaIcons.chevron_right,
          //     color: AppColors.kWhite,
          //   ),
          //   onTap: () {
          //     Get.to(() => const ThemeView());
          //   },
          // ),
          // ListTile(
          //   leading:
          //       const ColorIcon(icon: EvaIcons.music, color: AppColors.kRed200),
          //   title: Text(
          //     'Music and Playback',
          //     style: AppTypography.kBold16.copyWith(letterSpacing: 1),
          //   ),
          //   trailing: const Icon(
          //     EvaIcons.chevron_right,
          //     color: AppColors.kWhite,
          //   ),
          // ),
          // ListTile(
          //   leading: const ColorIcon(
          //       icon: EvaIcons.download, color: AppColors.kBrown75),
          //   title: Text(
          //     'Download',
          //     style: AppTypography.kBold16.copyWith(letterSpacing: 1),
          //   ),
          //   trailing: const Icon(
          //     EvaIcons.chevron_right,
          //     color: AppColors.kWhite,
          //   ),
          // ),
          // ListTile(
          //   leading: const ColorIcon(
          //       icon: EvaIcons.activity, color: AppColors.kRed100),
          //   title: Text(
          //     'History',
          //     style: AppTypography.kBold16.copyWith(letterSpacing: 1),
          //   ),
          //   trailing: const Icon(
          //     EvaIcons.chevron_right,
          //     color: AppColors.kWhite,
          //   ),
          // )
        ],
      ),
    );
  }
}
