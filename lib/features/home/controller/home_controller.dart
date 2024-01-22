import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/home/model/home.dart';
import 'package:music_stream/features/home/model/home_model.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/features/home/service/home_service.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/logic/networking/app_popups.dart';
import 'package:music_stream/utils/logic/networking/dio_exception_handler.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/logic/networking/logger.dart';
import 'package:music_stream/utils/ui/constants/app_texts.dart';

class HomeController extends GetxController {
  // Variables
  var home = Home();

  // Service
  var service = HomeService();

  // Get List of HomeModel
  Future<void> getQuickpicks({bool isSplash = false}) async {
    if (!Get.isSnackbarOpen) {
      try {
        // AppPopups.showDialog();

        var response = await service.getQuickpicks();
        if (isSplash) {
          Get.offAll(
            () => const BottomView(),
            // transition: Transition.downToUp,
          );
        }
        // AppPopups.cancelDialog();
        home.homeList.clear();
        List songList = response.data;
        // logger.i(songList.length,
        //     error: 'HomeController getQuickpicks() songList');
        for (int i = 0; i < songList.length; i++) {
          var song = songList[i];
          home.homeList.add(HomeModel.fromJson(song));
        }
        // logger.i(home.homeList.first.title,
        //     error: 'HomeController getQuickpicks() homeList');
      } on DioException catch (dioError) {
        DioExceptionHandler.dioError(dioError.type);
      } catch (error) {
        if (kDebugMode) {
          log(error.toString());
        }
      } finally {
        AppPopups.cancelDialog();
      }
    }
  }

//Listtile tap
  Future<void> listTileTap({required int index, required bool isHome}) async {
    Uri? audioSource;
    if (home.isForLoopRunning) {
      Get.snackbar(AppTexts.kTitleEng, 'Wait processing data in background');
      // logger.e('For Loop is Running ${home.isForLoopRunning}');
      return;
    }
    try {
      AppPopups.showDialog();
      // Clearing data
      await AudioHelper.player.stop();
      await AudioHelper.playlist.value.clear();
      AudioHelper.playlistList.clear();
      // logger.i(home.homeList[0].contents?.elementAt(index).videoId,
      //     error: index);
      String? videoId = isHome
          ? home.homeList[0].contents?.elementAt(index).videoId
          : Get.find<SearchCtr>().search.searchList[index].videoId;

      audioSource = await AudioHelper.getAudioUri(videoId: videoId!);
      if (audioSource == null) {
        // AppPopups.cancelDialog();
        // AppPopups.errorSnackbar(
        //     title: "Something went wrong",
        //     message: '''എവിടെയോ എന്തോ ഒരു തകരാറ് പോലെ....''');
        throw Exception('unavilableSong');
      } else {
        await getPlaylist(audioSource, videoId, index, isHome);
      }
    } on Exception catch (error) {
      AppPopups.cancelDialog();

      AppPopups.errorSnackbar(
          title: AppTexts.kTitle, message: error.toString());
    } catch (error) {
      AppPopups.cancelDialog();

      logger.e(error, error: 'HomeController listTileTap()');
    } finally {
      home.isForLoopRunning = false;
    }
  }

// Get Playlist
  Future<void> getPlaylist(
      Uri uri, String? videoId, int index, bool isHome) async {
    Uri? audio;

    dynamic data = isHome
        ? home.homeList[0].contents![index]
        : Get.find<SearchCtr>().search.searchList[index];
    await AudioHelper.playlist.value.add(
      AudioSource.uri(
        uri,
        tag: MediaItem(
          id: data.videoId!,
          title: data.title!,
          artUri: Uri.parse(data.thumbnails!.last.url!),
        ),
      ),
    );
    await AudioHelper.player.setAudioSource(AudioHelper.playlist.value,
        initialIndex: 0, initialPosition: Duration.zero, preload: false);

    // call api
    var response = await service.getPlaylist(videoId: videoId);
    List tracks = response.data["tracks"];
    AudioHelper.playlistList.add(PlaylistModel.fromJson(tracks[0]));
    // playing song
    AudioHelper.player.play();
    AppPopups.cancelDialog();
    // go now play
    // Get.find<BottomController>().bottom.selectedIndex.value = 1;

    // add song to queue
    home.isForLoopRunning = true;
    for (var i = 1; i < tracks.length; i++) {
      var id = tracks[i]["videoId"];

      audio = await AudioHelper.getAudioUri(videoId: id);
      if (audio != null) {
        AudioHelper.playlistList.add(PlaylistModel.fromJson(tracks[i]));
        await AudioHelper.playlist.value.add(
          AudioSource.uri(
            audio,
            tag: MediaItem(
              id: AudioHelper.playlistList.elementAt(i).videoId!,
              title: AudioHelper.playlistList.elementAt(i).title!,
              artUri: Uri.parse(
                  AudioHelper.playlistList.elementAt(i).thumbnail!.last.url!),
            ),
          ),
        );
      }
    }
    home.isForLoopRunning = false;
  }

  ///Get wallpaper from Unsplash Api.
  ///
  /* Future getWallpaper() async {
    try {
      var response = await service.getWallpaper();
      // logger.d(response, error: 'HomeController getWallpaper() response');
      home.wallpaperModel.value = WallpaperModel.fromJson(response.data);
      // update();
      // logger.d(home.wallpaperModel.value.urls?.full,
      //     error: 'HomeController getWallpaper() wallpaper data');
    } on DioException catch (dioError) {
      logger.f(dioError, error: 'HomeController getWallpaper() DioException');
    } catch (error) {
      logger.f(error, error: 'HomeController getWallpaper() catch');
    }
  }
  */

// // Call the getQuickpicks method in the onReady -> Get called after widget is rendered on the screen
//   @override
//   void onReady() {
//     getQuickpicks();
//     super.onReady();
//   }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        // getWallpaper(),
        getQuickpicks(isSplash: true),
      ]);
    });
  }
}
