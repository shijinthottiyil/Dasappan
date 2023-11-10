import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';

class AllControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<PlaylistController>(() => PlaylistController(), fenix: true);
  }
}
