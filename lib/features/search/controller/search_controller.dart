import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/search/model/playlist_model.dart';
import 'package:music_stream/features/search/model/search.dart';
import 'package:music_stream/features/search/model/search_model.dart';
import 'package:music_stream/features/search/service/search_service.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/constants/app_typography.dart';
import 'package:music_stream/utils/general_widgets.dart/avatar_glow.dart';
import 'package:music_stream/utils/networking/app_popups.dart';
import 'package:music_stream/utils/networking/dio_exception_handler.dart';
import 'package:music_stream/utils/networking/logger.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

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

  ///Method to execute when the user presses the voice search icon.
  ///
  Future voiceSearchTap() async {
    bool isAvilable = await search.speechToText.initialize();
    if (isAvilable) {
      // search.isListening.value = true;
      if (search.speechToText.isListening) {
        await search.speechToText.stop();
        return;
      }

      // Get.snackbar('Title', 'Started Listening');
      await search.speechToText.listen(
        onResult: (result) {
          search.speechData.value = result.recognizedWords;
          // logger.i(search.speechData.value);
          // logger.i(search.speechData.value);
          // logger.i(search.speechToText.lastStatus);
          // if (search.speechToText.lastStatus == 'notListening') {
          //   logger.i(search.speechData.value);
          //   getSearch(search.speechData.value);
          // }
          if (search.speechToText.isNotListening) {
            logger.i(search.speechData.value);
            getSearch(search.speechData.value);
          }
        },
      );
    } else {
      Get.snackbar('title', 'message');
    }
  }

  Future voiceSearchDismiss() async {
    search.isListening.value = false;
    await search.speechToText.stop();
  }
}
