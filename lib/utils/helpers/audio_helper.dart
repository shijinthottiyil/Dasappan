import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/utils/constants/app_texts.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioHelper {
  static final player = AudioPlayer();
  static final youtubeExplode = YoutubeExplode();
  static var duration = const Duration();
  static var position = const Duration();

  ///Instance of GetStorage to AudioQuality.
  ///
  static final audioBox = GetStorage();

  ///Variable keep track of User Selected AudioQuality.
  ///
  static String audioQuality =
      audioBox.read(AppTexts.kStrorageKey) ?? AppTexts.kMedium;
  // Playlist
  static var playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [],
  ).obs;

// Playlist List
  static var playlistList = List<PlaylistModel>.empty(growable: true).obs;

  // <============================================= METHOD FOR GETTING AUDIOURL FROM VIDEO ID============================================>
  static Future<Uri?> getAudioUri({
    required String videoId,
  }) async {
    var audioUrl = "";

    ///Reading the User Selected AudioQuality.
    ///
    String audioQuality =
        audioBox.read(AppTexts.kStrorageKey) ?? AppTexts.kMedium;
    try {
      final StreamManifest manifest =
          await youtubeExplode.videos.streamsClient.getManifest(videoId);

      ///New Code After AudioQuality Change Functionality.
      ///
      List<AudioOnlyStreamInfo> audios = manifest.audioOnly.sortByBitrate();
      int audioNumber = audioQuality == AppTexts.kHigh
          ? audios.length - 1
          : (audioQuality == AppTexts.kLow ? 0 : (audios.length / 2).floor());
      audioUrl = manifest.audioOnly.sortByBitrate()[audioNumber].url.toString();
      return Uri.parse(audioUrl);
    } catch (e) {
      // log(e.toString());

      return null;
    }
  }

  ///Method For Changing the AudioQuality.
  ///
  static changeAudioQualtiy(String? quality) {
    String? _quality;

    switch (quality) {
      case AppTexts.kHigh:
        _quality = AppTexts.kHigh;
        // selectAudioQuality = AudioQuality.high;
        // audioQuality = 'high';
        break;
      case AppTexts.kMedium:
        _quality = AppTexts.kMedium;
        // selectAudioQuality = AudioQuality.medium;
        break;
      case AppTexts.kLow:
        _quality = AppTexts.kLow;
      // selectAudioQuality = AudioQuality.low;
      default:
        break;
    }
    audioBox.write(AppTexts.kStrorageKey, _quality);
    // logger.i(audioBox.read('audioQuality'),
    //     error: 'AudioHelper changeAudioQuality audioQuality box value');
  }
}
