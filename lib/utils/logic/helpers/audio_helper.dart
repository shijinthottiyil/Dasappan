import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/utils/logic/networking/networking.dart';
import 'package:music_stream/utils/ui/constants/app_texts.dart';

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

  ///Method to play all songs in the current playlist one by one when user clicks the FAB.
  static Future playAll(List<PlaylistModel> playlistList) async {
    ///Initializing the Player.
    AppPopups.showDialog();
    await AudioHelper.player.stop();
    await AudioHelper.playlist.value.clear();
    AudioHelper.playlistList.clear();

    ///Playing the first song.
    Uri? audioSource;
    audioSource =
        await AudioHelper.getAudioUri(videoId: playlistList.first.videoId!);
    if (audioSource != null) {
      await AudioHelper.playlist.value.add(
        AudioSource.uri(
          audioSource,
          tag: MediaItem(
            id: playlistList.first.videoId!,
            title: playlistList.first.title!,
            artUri: Uri.parse(playlistList.first.thumbnail!.last.url!),
          ),
        ),
      );
      await AudioHelper.player.setAudioSource(
        AudioHelper.playlist.value,
        initialIndex: 0,
        initialPosition: Duration.zero,
        preload: false,
      );

      AudioHelper.player.play();
      AppPopups.cancelDialog();
      // go now play
      // Get.find<BottomController>().bottom.selectedIndex.value = 1;
      // Get.back();

      ///Show snackbar on success.
      Get.snackbar(
        AppTexts.kTitle,
        'Playing this Playlist',
        // snackPosition: SnackPosition.BOTTOM,
      );

      AudioHelper.playlistList.add(playlistList.first);

      ///Adding the rest of the songs to play.
      for (var i = 1; i < playlistList.length; i++) {
        var data = playlistList[i];
        Uri? _audioSource;
        _audioSource = await AudioHelper.getAudioUri(videoId: data.videoId!);
        if (_audioSource != null) {
          AudioHelper.playlistList.add(data);
          await AudioHelper.playlist.value.add(
            AudioSource.uri(
              _audioSource,
              tag: MediaItem(
                id: data.videoId!,
                title: data.title!,
                artUri: Uri.parse(data.thumbnail!.last.url!),
              ),
            ),
          );
        }
      }
    } else {
      AppPopups.errorSnackbar(title: AppTexts.kTitle, message: 'Sorry');
    }
  }

  ///Method to play the user selected song first.
  static Future playSelected(
      int index, List<PlaylistModel> playlistList) async {
    ///Initializing the Player.
    AppPopups.showDialog();
    await AudioHelper.player.stop();
    await AudioHelper.playlist.value.clear();
    AudioHelper.playlistList.clear();

    ///Playing the user selected song first.
    Uri? audioSource;
    audioSource =
        await AudioHelper.getAudioUri(videoId: playlistList[index].videoId!);
    if (audioSource != null) {
      await AudioHelper.playlist.value.add(
        AudioSource.uri(
          audioSource,
          tag: MediaItem(
            id: playlistList[index].videoId!,
            title: playlistList[index].title!,
            artUri: Uri.parse(playlistList[index].thumbnail!.last.url!),
          ),
        ),
      );
      await AudioHelper.player.setAudioSource(
        AudioHelper.playlist.value,
        initialIndex: 0,
        initialPosition: Duration.zero,
        preload: false,
      );

      AudioHelper.player.play();
      AppPopups.cancelDialog();
      // go now play
      // Get.find<BottomController>().bottom.selectedIndex.value = 1;
      // Get.back();
      //
      ///Show snackbar on success.
      Get.snackbar(
        AppTexts.kTitle,
        'Playing Selected Song',
        // snackPosition: SnackPosition.BOTTOM,
      );

      AudioHelper.playlistList.add(playlistList[index]);

      ///Adding the rest of the songs to play.
      for (var i = 0; i < playlistList.length; i++) {
        if (i == index) {
          continue;
        }

        var data = playlistList[i];
        Uri? _audioSource;
        _audioSource = await AudioHelper.getAudioUri(videoId: data.videoId!);
        if (_audioSource != null) {
          AudioHelper.playlistList.add(data);
          await AudioHelper.playlist.value.add(
            AudioSource.uri(
              _audioSource,
              tag: MediaItem(
                id: data.videoId!,
                title: data.title!,
                artUri: Uri.parse(data.thumbnail!.last.url!),
              ),
            ),
          );
        }
      }
    } else {
      AppPopups.cancelDialog();
      AppPopups.errorSnackbar(title: AppTexts.kTitle, message: 'Sorry');
    }
  }
}
