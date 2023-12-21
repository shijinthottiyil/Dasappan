import 'package:get/get.dart';
import 'package:music_stream/features/settings/model/settings.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class SettingsController extends GetxController {
  ///Variables.
  var settings = Settings();

  ///Methods.
  //Method to Change AudioQuality.
  void changeAudioQuality(String? selectedAudioQuality) {
    AudioHelper.changeAudioQualtiy(selectedAudioQuality);
    settings.quality.value = selectedAudioQuality!;
  }
}
