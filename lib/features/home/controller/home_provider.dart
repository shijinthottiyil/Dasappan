import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/controller/music_controller.dart';
import 'package:music_stream/features/now_playing/view/now_playing_page.dart';
import 'package:music_stream/features/search/view/search_page.dart';
import 'package:music_stream/model/song_model.dart';
import 'package:music_stream/utils/constants/api.dart';
import 'package:music_stream/view/now_playing/now_play_screen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final homePageProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  return HomeProvider();
});

class HomeProvider with ChangeNotifier {
  //VARIABLE FOR FETCHING QUICKPICKS
  List<SongModel> songModelList = [];

  //VARIABLE FOR SHOWING MINI PLAYER
  var isMiniShown = false;

  //VARIABLE FOR KEEP TRACK OF THE CURRENT PLAYING SONG
  List<SongModel> playingSongModelList = [];

  // <================================== VOLUME CONTROL ==================================================>
  var currentVolume = 0.5;

  // METHOD TO NAVIGATE TO SEARCH SCREEN
  void goSearch({required BuildContext context}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return SearchPage();
        },
      ),
    );
  }

  //METHOD FOR FETCHING QUICKPICKS
  Future<void> fetchQuickPicks() async {
    final response = await Dio().get(KApi.homeUrl);
    if (response.statusCode == 200) {
      List songList = response.data[0]["contents"];
      log(songList.toString());
      for (var song in songList) {
        songModelList.add(SongModel.fromJson(song));
      }
      notifyListeners();
    }
  }

  // METHOD FOR LISTTILE ONTAP
  Future<void> songTap(
      {required String videoId, required int selectedIndex}) async {
    try {
      AudioSource? audioSource;
      playingSongModelList.clear();
      await MusicController.player.stop();
      await MusicController.playlist.clear();
      await MusicController.player.setAudioSource(
        MusicController.playlist,
        initialIndex: 0,
        initialPosition: Duration.zero,
        preload: false,
      );
      audioSource = await getAudioSource(videoId: videoId);
      if (audioSource != null) {
        playingSongModelList.add(songModelList.elementAt(selectedIndex));
        await MusicController.playlist.add(audioSource);
        isMiniShown = true;
        notifyListeners();
        MusicController.player.play();

        await getWatchPlaylist(videoId: videoId, limit: 10).then((value) async {
          // playingSongModelList.elementAt(0).thumbnails = value.elementAt(0).thumbnails;
          // log(value.elementAt(0).thumbnails);
          playingSongModelList[0].thumbnails = value[0].thumbnails;
          value.removeAt(0);
          // log(playingSongModelList[0].thumbnails);
          notifyListeners();
          for (int i = 0; i < 10; i++) {
            SongModel song = value[i];
            await getAudioSource(videoId: song.videoId)
                .then((audioSource) async {
              if (audioSource != null) {
                playingSongModelList.add(value.elementAt(i));
                await MusicController.playlist.add(audioSource);
                notifyListeners();
              }
            });
          }
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // <============================================= METHOD FOR GETTING AUDIOURL FROM VIDEO ID============================================>
  Future<AudioSource?> getAudioSource({required String videoId}) async {
    var audioUrl = "";
    try {
      final StreamManifest manifest = await MusicController
          .youtubeExplode.videos.streamsClient
          .getManifest(videoId);
      audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();
      return AudioSource.uri(Uri.parse(audioUrl));
    } catch (e) {
      // log(e.toString());
      await Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.redAccent,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
      return null;
    }
  }

  // <=============================================== METHOD FOR PLAY AND PAUSE =======================================>
  Future<void> playOrPause() async {
    if (MusicController.player.playing) {
      await MusicController.player.pause();
      notifyListeners();
    } else {
      notifyListeners();
      await MusicController.player.play();
    }
  }

  // <============================================== METHOD FOR SHOWING SHOWMODAL BOTTOMSHEET===========================================>
  Future<void> getModelSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NowPlayingPage();
      },
    );
  }

  // <================================ METHOD FOR FAST FORWARD ===============================>
  fastForward() {
    var sec10 = const Duration(seconds: 10);
    if (MusicController.position + sec10 > MusicController.duration) {
      MusicController.position = MusicController.duration;

      MusicController.player.seek(MusicController.position);
      notifyListeners();
      return;
    }
    MusicController.position += sec10;
    MusicController.player.seek(MusicController.position);
    notifyListeners();
  }

  // <============================ METHOD FOR FAST BACKWARD ====================================>
  fastBackward() {
    var sec10 = const Duration(seconds: 10);
    if (MusicController.position < sec10) {
      MusicController.position = Duration.zero;
      MusicController.player.seek(MusicController.position);
      notifyListeners();
      return;
    }
    MusicController.position -= sec10;
    MusicController.player.seek(MusicController.position);
    notifyListeners();
  }

  // <=============================== METHOD SEEK NEXT ========================================>
  Future<void> next() async {
    await MusicController.player.seekToNext();
  }

  // <============================== METHOD TO SEEK PREVIOUS ===================================>
  Future<void> previous() async {
    await MusicController.player.seekToPrevious();
  }

  // <============================ Repeat or SET LOOP MODE =======================================>
  Future<void> repeat() async {
    if (LoopMode == LoopMode.off) {
      await MusicController.player.setLoopMode(LoopMode.one);
      notifyListeners();
    } else {
      notifyListeners();
      await MusicController.player.setLoopMode(LoopMode.off);
    }
  }

  // <=================================METHOD FOR VOLUME CONTROL ======================================>
  Future<void> controlVolume(double volume) async {
    currentVolume = volume;
    await MusicController.player.setVolume(currentVolume);
    notifyListeners();
  }

  // METHOD FOR FETCHING QUEUE DATA
  Future<List<SongModel>> getWatchPlaylist(
      {required String videoId, required int limit}) async {
    List<SongModel> playlistList = [];
    final response = await Dio().get(
        "${KApi.baseUrl}/searchwatchplaylist?videoId=$videoId&limit=$limit");
    if (response.statusCode == 200) {
      List tracks = response.data["tracks"];
      log(tracks.toString());
      for (var track in tracks) {
        playlistList.add(SongModel.fromJson(track));
      }
      return playlistList;
    }
    return playlistList;
  }
}
