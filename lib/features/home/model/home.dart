import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/home/model/home_model.dart';
import 'package:music_stream/features/home/model/wallpaper_model.dart';

class Home {
// List of HomeModel
  var homeList = List<HomeModel>.empty(growable: true).obs;

  //Instance of WallpaperModel.
  var wallpaperModel = WallpaperModel().obs;

  ///boolean variable to check if the for loop is running.
  bool isForLoopRunning = false;

  // // Playlist List
  // var playlistList = List<PlaylistModel>.empty(growable: true).obs;

  // Playlist
  var playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [],
  ).obs;

  // Duration and position
  var duration = const Duration(seconds: 10).obs;
  var position = const Duration(seconds: 0).obs;
}
