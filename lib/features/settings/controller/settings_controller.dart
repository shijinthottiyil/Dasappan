import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/settings/model/settings.dart';
import 'package:music_stream/utils/constants/app_texts.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class SettingsController extends GetxController {
  ///Variables.
  var settings = Settings();

  ///Methods.

  ///Method to Change AudioQuality.
  void changeAudioQuality(String? selectedAudioQuality) {
    AudioHelper.changeAudioQualtiy(selectedAudioQuality);
    settings.quality.value = selectedAudioQuality!;
  }

  ///Method to Show TimerPicker.
  void showTimerPicker(BuildContext context) {
    if (!AudioHelper.player.playing) {
      Get.snackbar(AppTexts.kTitle, 'Not playing anything');
      return;
    }
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            initialTimerDuration: settings.countDownDuration.value,
            // This is called when the user changes the timer's
            // duration.
            onTimerDurationChanged: (Duration newDuration) {
              settings.countDownTimer?.cancel();
              int seconds = newDuration.inSeconds;
              settings.countDownDuration.value = Duration.zero;

              settings.countDownTimer = Timer.periodic(
                const Duration(seconds: 1),
                (timer) {
                  settings.countDownDuration.value = Duration(seconds: seconds);

                  if (seconds == 0) {
                    timer.cancel();
                    settings.countDownDuration.value = Duration.zero;
                    settings.countDownTimer?.cancel();
                    AudioHelper.player.pause();
                  }
                  seconds--;
                  // log(settings.countDownDuration.value.inSeconds.toString());
                },
              );
            },
          ),
        ),
      ),
    );
  }

  ///Method to format CountdownTimer.
  String formatCountdownTimer(int n) {
    return n.toString().padLeft(2, '0');
  }
}
