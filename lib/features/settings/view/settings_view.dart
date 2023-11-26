import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/settings/view/theme_view.dart';
import 'package:music_stream/features/settings/view/widgets/color_icon.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/constants/app_typography.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/constants/enums.dart';
import 'package:music_stream/utils/general_widgets.dart/common_scaffold.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String quality = AudioHelper.audioQuality;
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      onWillPop: () async {
        if (pc.isPanelOpen) {
          pc.close();
        } else {
          Get.find<BottomController>().bottom.selectedIndex.value = 1;
        }

        return false;
      },
      appBarTitle: 'Settings',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              leading: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.kGreen,
                    borderRadius: BorderRadius.circular(5).r,
                  ),
                  child: Icon(
                    Icons.music_note_rounded,
                    color: AppColors.kWhite,
                  )),
              title: Text(
                'Audio Quality',
                style: AppTypography.kSecondary,
              ),
              children: [
                RadioListTile<String>(
                  title: const Text('High'),
                  value: AppTexts.kHigh,
                  groupValue: quality,
                  onChanged:
                      // (AudioQuality? value) {
                      //   AudioHelper.changeAudioQualtiy(value);
                      //   setState(() {
                      //     _quality = value;
                      //   });
                      // },
                      (String? value) {
                    AudioHelper.changeAudioQualtiy(value);
                    setState(() {
                      quality = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Medium'),
                  value: AppTexts.kMedium,
                  groupValue: quality,
                  onChanged:
                      // (AudioQuality? value) {
                      //   AudioHelper.changeAudioQualtiy(value);
                      //   setState(() {
                      //     _quality = value;
                      //   });
                      // },
                      (String? value) {
                    AudioHelper.changeAudioQualtiy(value);
                    setState(() {
                      quality = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Low'),
                  value: AppTexts.kLow,
                  groupValue: quality,
                  onChanged:
                      // (AudioQuality? value) {
                      //   AudioHelper.changeAudioQualtiy(value);
                      //   setState(() {
                      //     _quality = value;
                      //   });
                      // },
                      (String? value) {
                    AudioHelper.changeAudioQualtiy(value);
                    setState(() {
                      quality = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
