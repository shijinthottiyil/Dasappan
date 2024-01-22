import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/settings/controller/settings_controller.dart';
import 'package:music_stream/features/settings/view/widgets/settings_icon_widget.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: AppSpacing.gapPSH16,
        child: Column(
          children: [
            // Audio Quality Section.
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
                  ),
                ),
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
            // -------------------------------------------------------------------------------------------------------
            // Timer
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const SettingsIconWidget(
                icon: Icons.timer_rounded,
                color: AppColors.kRed,
              ),
              title: const Text('Sleep Timer'),
              trailing: Obx(
                () {
                  final hours = c.formatCountdownTimer(
                      c.settings.countDownDuration.value.inHours.remainder(24));
                  final minutes = c.formatCountdownTimer(c
                      .settings.countDownDuration.value.inMinutes
                      .remainder(60));
                  final seconds = c.formatCountdownTimer(c
                      .settings.countDownDuration.value.inSeconds
                      .remainder(60));
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (c.settings.countDownDuration.value !=
                          Duration.zero) ...[
                        Text('$hours:$minutes:$seconds'),
                        AppSpacing.gapW4,
                        GestureDetector(
                          onTap: () {
                            c.settings.countDownTimer?.cancel();
                            c.settings.countDownDuration.value = Duration.zero;
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            size: 16,
                          ),
                        ),
                      ]
                    ],
                  );
                },
              ),
              onTap: () {
                // Duration duration = const Duration(hours: 1, minutes: 23);
                c.showTimerPicker(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
