import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/favorites/model/favorite.dart';
import 'package:music_stream/features/favorites/model/favorite_model.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/utils/logic/database/database_manager.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/logic/networking/logger.dart';
import 'package:music_stream/utils/logic/networking/networking.dart';

class FavoriteController extends GetxController {
  //Variables.
  final variables = Favorite();
  @override
  void onInit() {
    super.onInit();
    getAllFavoriteTableData();
  }

  //Local Future Method to fetch ids stored in FavoriteTable and add them to the List.
  Future<void> getAllFavoriteTableData() async {
    variables.favoriteDbIdsList.clear();
    variables.favoriteModelList.clear();
    final result = await DatabaseManager.readFavoriteIds();

    //Looping over result and adding each ids into the favoriteDbIdsList
    for (var index in result) {
      // favoriteDbIds.add(row[_favoriteColumnId] as String);
      variables.favoriteModelList.add(FavoriteModel.fromMap(index));
      variables.favoriteDbIdsList.add(index['videoId'] as String);
    }

    logger.i(variables.favoriteDbIdsList,
        error: 'Ids in the Favorite Database');
  }

  ///Method Add id to favoriteDbIdsList
  void addFavoriteIds({required String videoId}) {
    variables.favoriteDbIdsList.add(videoId);

    // variables.favoriteDbIdsList.add(id);
  }

  ///Method Delete id to favoriteDbIdsList
  void deleteFavoriteIds({required String videoId}) {
    variables.favoriteDbIdsList.remove(videoId);
  }

  ///Method to play  FavoriteSongs
  playFavorite({required FavoriteModel favoriteModel}) async {
    Uri? audioSource;
    AppPopups.showDialog();
    // Clearing data
    await AudioHelper.player.stop();
    await AudioHelper.playlist.value.clear();
    AudioHelper.playlistList.clear();
    audioSource = await AudioHelper.getAudioUri(videoId: favoriteModel.videoId);
    if (audioSource != null) {
      await AudioHelper.playlist.value.add(
        AudioSource.uri(
          audioSource,
          tag: MediaItem(
            id: favoriteModel.videoId,
            title: favoriteModel.videoTitle,
            artUri: Uri.parse(favoriteModel.videoThumbnail),
          ),
        ),
      );
      await AudioHelper.player.setAudioSource(AudioHelper.playlist.value,
          initialIndex: 0, initialPosition: Duration.zero, preload: false);
      var demoThumbnail = Thumbnail(url: favoriteModel.videoThumbnail);
      var demoPlaylistModel = PlaylistModel(
          thumbnail: [demoThumbnail],
          title: favoriteModel.videoTitle,
          videoId: favoriteModel.videoId);
      AudioHelper.playlistList.add(demoPlaylistModel);
      AudioHelper.player.play();
      AppPopups.cancelDialog();
    }
  }

  ///Method to play all songs From favorites
  Future<void> playAll({int index = 0}) async {
    try {
      Uri? audio;

      FavoriteModel favModel;
      String videoId;
      AppPopups.showDialog();
      // Clearing data
      await AudioHelper.player.stop();
      await AudioHelper.playlist.value.clear();
      AudioHelper.playlistList.clear();

      favModel = variables.favoriteModelList[index];
      videoId = variables.favoriteModelList[index].videoId;
      audio = await AudioHelper.getAudioUri(videoId: videoId);
      if (audio != null) {
        var thumbnail = Thumbnail(url: favModel.videoThumbnail);
        var playlistModel = PlaylistModel(
          thumbnail: [thumbnail],
          title: favModel.videoTitle,
          videoId: favModel.videoId,
        );
        AudioHelper.playlistList.add(playlistModel);
        await AudioHelper.playlist.value.add(
          AudioSource.uri(
            audio,
            tag: MediaItem(
              id: favModel.videoId,
              title: favModel.videoTitle,
              artUri: Uri.parse(favModel.videoThumbnail),
            ),
          ),
        );
        await AudioHelper.player.setAudioSource(AudioHelper.playlist.value,
            initialIndex: 0, initialPosition: Duration.zero, preload: false);
        AudioHelper.player.play();
        AppPopups.cancelDialog();
      }

      for (var i = 0; i < variables.favoriteModelList.length; i++) {
        if (i == index) continue;
        favModel = variables.favoriteModelList[i];
        videoId = variables.favoriteModelList[i].videoId;

        audio = await AudioHelper.getAudioUri(videoId: videoId);
        if (audio != null) {
          var demoThumbnail = Thumbnail(url: favModel.videoThumbnail);
          var demoPlaylistModel = PlaylistModel(
              thumbnail: [demoThumbnail],
              title: favModel.videoTitle,
              videoId: favModel.videoId);
          AudioHelper.playlistList.add(demoPlaylistModel);
          await AudioHelper.playlist.value.add(
            AudioSource.uri(
              audio,
              tag: MediaItem(
                id: favModel.videoId,
                title: favModel.videoTitle,
                artUri: Uri.parse(favModel.videoThumbnail),
              ),
            ),
          );

          // await AudioHelper.player.setAudioSource(AudioHelper.playlist.value,
          //     initialIndex: 0, initialPosition: Duration.zero, preload: false);
        }
      }
    } catch (error) {
      AppPopups.cancelDialog();
      logger.e(error.toString(), error: 'FavoriteController playAll() catch');
    }
  }
}
