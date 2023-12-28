import 'dart:async';

import 'package:get/get.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class Settings {
  var quality = AudioHelper.audioQuality.obs;

  ///Variable to keep track of user selected countDownDuration.
  var countDownDuration = Duration.zero.obs;

  ///Timer to operate the CountDown functionality.
  Timer? countDownTimer;
}
