import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';
import 'package:music_stream/utils/logic/networking/connection_controller.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<PlaylistController>(() => PlaylistController(), fenix: true);
    Get.put(ConnectionController(), permanent: true);
  }
}
