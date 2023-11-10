import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/search/model/playlist_model.dart';
import 'package:music_stream/features/search/model/search.dart';
import 'package:music_stream/features/search/model/search_model.dart';
import 'package:music_stream/features/search/service/search_service.dart';
import 'package:music_stream/utils/networking/app_popups.dart';
import 'package:music_stream/utils/networking/dio_exception_handler.dart';

class SearchCtr extends GetxController {
  // variables
  var search = Search();

  // service
  var service = SearchService();

  // Get search
  Future<void> getSearch(String keyword) async {
    try {
      AppPopups.showDialog();

      var response = await service.getSearch(keyword);
      AppPopups.cancelDialog();
      search.searchList.clear();
      search.playlistModelList.clear();
      List songs = response.data["songs"];
      for (var i = 0; i < songs.length; i++) {
        search.searchList.add(SearchModel.fromJson(songs[i]));
      }

      ///Experimenting playlist
      List playlists = response.data['playlists'];
      for (var i = 0; i < playlists.length; i++) {
        var json = playlists[i];
        search.playlistModelList.add(PlaylistModel.fromJson(json));
      }
    } on DioException catch (dioError) {
      DioExceptionHandler.dioError(dioError.type);
    } catch (error) {
      AppPopups.cancelDialog();
      log(error.toString(), name: "Search Control error");
    }
  }
}
