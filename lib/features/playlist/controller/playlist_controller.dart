import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/playlist/model/playlist.dart';
import 'package:music_stream/features/playlist/service/playlist_service.dart';
import 'package:music_stream/utils/constants/app_texts.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';
import 'package:music_stream/utils/networking/networking.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';

class PlaylistController extends GetxController {
  ///Variables.
  var playlist = Playlist();

  ///Service.
  var service = PlaylistService();

  ///Method to fetch all songs to display in the playlist view.[kPlaylistList].
  Future<List<PlaylistModel>> getPlaylistList(String? browseId) async {
    try {
      AppPopups.showDialog();

//Implimenting PersistentBottomNavigation Bar And Find a Small Bug and Fixing That.
      playlist.playlistList = [];

      var response = await service.getPlaylistList(browseId);
      // logger.f(response,
      //     error: 'PlaylistController getPlaylistList() response');
      AppPopups.cancelDialog();
      List trackList = response.data['tracks'];
      // logger.f(trackList,
      //     error: 'PlaylistController getPlaylistList() trackList');
      for (var i = 0; i < trackList.length; i++) {
        var json = trackList[i];
        playlist.playlistList.add(PlaylistModel.fromJson(json));
      }
      return playlist.playlistList;
    } on DioException catch (dioError) {
      DioExceptionHandler.dioError(dioError.type);
    } catch (err) {
      AppPopups.cancelDialog();
      logger.e(err, error: 'PlaylistController getPlaylistList() catch');
    }
    return playlist.playlistList;
  }

//  ///Method to play all songs in the current playlist one by one when user clicks the FAB.
  Future playAll() async {
    ///Initializing the Player.
    AppPopups.showDialog();
    await AudioHelper.player.stop();
    await AudioHelper.playlist.value.clear();
    AudioHelper.playlistList.clear();

    ///Playing the first song.
    Uri? audioSource;
    audioSource = await AudioHelper.getAudioUri(
        videoId: playlist.playlistList.first.videoId!);
    if (audioSource != null) {
      await AudioHelper.playlist.value.add(
        AudioSource.uri(
          audioSource,
          tag: MediaItem(
            id: playlist.playlistList.first.videoId!,
            title: playlist.playlistList.first.title!,
            artUri: Uri.parse(playlist.playlistList.first.thumbnail!.last.url!),
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
        snackPosition: SnackPosition.BOTTOM,
      );

      AudioHelper.playlistList.add(playlist.playlistList.first);

      ///Adding the rest of the songs to play.
      for (var i = 1; i < playlist.playlistList.length; i++) {
        var data = playlist.playlistList[i];
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
  Future playSelected(int index) async {
    ///Initializing the Player.
    AppPopups.showDialog();
    await AudioHelper.player.stop();
    await AudioHelper.playlist.value.clear();
    AudioHelper.playlistList.clear();

    ///Playing the user selected song first.
    Uri? audioSource;
    audioSource = await AudioHelper.getAudioUri(
        videoId: playlist.playlistList[index].videoId!);
    if (audioSource != null) {
      await AudioHelper.playlist.value.add(
        AudioSource.uri(
          audioSource,
          tag: MediaItem(
            id: playlist.playlistList[index].videoId!,
            title: playlist.playlistList[index].title!,
            artUri:
                Uri.parse(playlist.playlistList[index].thumbnail!.last.url!),
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
        snackPosition: SnackPosition.BOTTOM,
      );

      AudioHelper.playlistList.add(playlist.playlistList[index]);

      ///Adding the rest of the songs to play.
      for (var i = 0; i < playlist.playlistList.length; i++) {
        if (i == index) {
          continue;
        }

        var data = playlist.playlistList[i];
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
}
