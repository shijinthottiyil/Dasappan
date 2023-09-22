import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/model/home.dart';
import 'package:music_stream/features/home/model/home_model.dart';
import 'package:music_stream/features/home/service/home_service.dart';
import 'package:music_stream/utils/networking/app_popups.dart';

class HomeController extends GetxController {
  // Variables
  var home = Home();

  // Service
  var service = HomeService();

  // Get List of HomeModel
  Future<void> getQuickpicks() async {
    try {
      AppPopups.showDialog();
      var response = await service.getQuickpicks();
      List songList = response.data[0]["contents"];
      for (var song in songList) {
        home.homeList.add(HomeModel.fromJson(song));
      }
      // log(response.data.toString());
    } on DioException catch (dioError) {
      log(dioError.toString());
    } catch (error) {
      log(error.toString());
    } finally {
      AppPopups.cancelDialog();
    }
  }

  //Calling getQuickpicks in the onInit gives error
  // @override
  // void onInit() {
  //   getQuickpicks();
  //   super.onInit();
  // }

// Call the getQuickpicks method in the onReady -> Get called after widget is rendered on the screen
  @override
  void onReady() {
    getQuickpicks();
    super.onReady();
  }
}
