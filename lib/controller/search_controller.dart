import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/model/search_model.dart';
import 'package:music_stream/utils/constants/api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final searchProvider = ChangeNotifierProvider<SearchController>((ref) {
  return SearchController();
});

class SearchController with ChangeNotifier {
  // <============================= VARIABLES ===========================================>
  var searchController = TextEditingController();
  var yt = YoutubeExplode();
  List<SearchModel> searchModelList = [];
  var isLoading = false;

  // <================================= METHODS =========================================>
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
}
