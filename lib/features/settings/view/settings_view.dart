import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/settings/controller/settings_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/general_widgets.dart/common_scaffold.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SettingsController());
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
            Obx(
              () => ExpansionTile(
                tilePadding: EdgeInsets.zero,
                leading: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.kGreen,
                      borderRadius: BorderRadius.circular(5).r,
                    ),
                    child: const Icon(
                      Icons.music_note_rounded,
                      color: AppColors.kWhite,
                    )),
                title: const Text(
                  'Audio Quality',
                ),
                children: [
                  RadioListTile<String>(
                    title: const Text('High'),
                    value: AppTexts.kHigh,
                    groupValue: c.settings.quality.value,
                    onChanged: (String? value) {
                      c.changeAudioQuality(value);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Medium'),
                    value: AppTexts.kMedium,
                    groupValue: c.settings.quality.value,
                    onChanged: (String? value) {
                      c.changeAudioQuality(value);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Low'),
                    value: AppTexts.kLow,
                    groupValue: c.settings.quality.value,
                    onChanged: (String? value) {
                      c.changeAudioQuality(value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
