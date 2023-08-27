import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/model/search_model.dart';
import 'package:music_stream/utils/constants/api.dart';
import 'package:music_stream/view/now_playing/nowplaying_screen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final searchProvider = ChangeNotifierProvider<SearchController>((ref) {
  return SearchController();
});

class SearchController with ChangeNotifier {
  // <============================= VARIABLES ===========================================>
  var searchController = TextEditingController();
  var yt = YoutubeExplode();
  final player = AudioPlayer();
  List<SearchModel> searchModelList = [];
  var isLoading = false;

  // <================================= METHODS =========================================>

  // <================================= METHOD FOR SEARCH ===============================>
  Future<List<SearchModel>> getSearch(String query) async {
    if (searchModelList.isNotEmpty) {
      searchModelList = [];
      notifyListeners();
    }
    isLoading = true;
    notifyListeners();
    SearchModel searchModel =
        SearchModel(videoId: "", title: "", thumbnails: "", artists: "");
    final response = await Dio().get("${KApi.baseUrl}/search?query=$query");
    if (response.statusCode == 200) {
      // log(response.data["songs"].toString());

      // for (var data in response.data["songs"]) {
      //   log(data.toString());
      // }
      List searchList = response.data["songs"];
      for (int i = 0; i < searchList.length; i++) {
        searchModel = SearchModel.fromJson(response.data, i);
        searchModelList.add(searchModel);
        // log(searchModel.toString());
      }
      // searchModel = SearchModel.fromJson(response.data);

      // <============== FOR PLAYING AUDIO FROM API =======================>
      // var audioUrl = "";
      // final StreamManifest manifest =
      //     await yt.videos.streamsClient.getManifest(searchModel.videoId);
      // audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();
      // final player = AudioPlayer();
      // await player.setUrl(audioUrl);
      // player.play();
      // log(searchModel.toString());
    }
    log(searchModelList.toString());
    isLoading = false;
    notifyListeners();
    searchController.clear();
    return searchModelList;
  }

  // <========================================== METHOD FOR NAVIGATING TO NOW PLAYING SCREEN ===============================================>
  void goNowPlay(BuildContext context,
      {required String url, required String title, required int index}) async {
    if (player.playing) {
      await player.pause();
    }
    var audioUrl = "";
    final StreamManifest manifest = await yt.videos.streamsClient
        .getManifest(searchModelList.elementAt(index).videoId);
    audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();

    await player.setUrl(audioUrl);

    player.play();
    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) {
            return NowPlayingScreen(
              url: url,
              title: title,
            );
          },
        ),
      );
    }
  }

  // <================================= METHOD FOR PLAY AND PAUSE MUSIC =======================================>
  Future<void> playOrPause() async {
    if (player.playing) {
      await player.pause();
      notifyListeners();
    } else if (!player.playing) {
      notifyListeners();
      await player.play();
    }
  }
}
