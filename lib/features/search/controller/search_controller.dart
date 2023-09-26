import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
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
      search.searchList.clear();
      var response = await service.getSearch(keyword);
      AppPopups.cancelDialog();
      List songs = response.data["songs"];
      for (var i = 0; i < songs.length; i++) {
        search.searchList.add(SearchModel.fromJson(songs[i]));
      }
    } on DioException catch (dioError) {
      DioExceptionHandler.dioError(dioError.type);
    } catch (error) {
      log(error.toString(), name: "Search Control error");
    } finally {
      AppPopups.cancelDialog();
    }
  }
}
