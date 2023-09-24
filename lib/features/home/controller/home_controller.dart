import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/home/model/home.dart';
import 'package:music_stream/features/home/model/home_model.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/features/home/service/home_service.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';
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
    } on DioException catch (dioError) {
      log(dioError.toString());
    } catch (error) {
      log(error.toString());
    } finally {
      AppPopups.cancelDialog();
    }
  }

//Listtile tap
  Future<void> listTileTap({required int index}) async {
    Uri? audioSource;
    try {
      AppPopups.showDialog();
      audioSource = await AudioHelper.getAudioUri(
        videoId: home.homeList.elementAt(index).videoId!,
      );
      if (audioSource == null) {
        throw Exception();
      } else {
        // await AudioHelper.player.stop();

        // //clear the playlist list if it contains any items
        // home.playlistList.clear();
        // home.playlist.value.clear();
        // await home.playlist.value.add(audioSource);
        // AudioHelper.player.setAudioSource(home.playlist.value,
        //     initialIndex: 0, initialPosition: Duration.zero, preload: false);
        // AudioHelper.player.play();
        // await getOne(
        //     videoId: home.homeList.elementAt(index).videoId!, index: index);

        // Get.find<BottomController>().bottom.selectedIndex.value = 1;
        // AppPopups.cancelDialog();
        // await getAll(videoId: home.homeList.elementAt(index).videoId!);
        // // listenPosition();
        // // listenDuration();

        await getPlaylist(
            audioSource, home.homeList.elementAt(index).videoId!, index);
      }
    } catch (error) {
      AppPopups.cancelDialog();
      AppPopups.errorSnackbar(title: "error", message: error.toString());
      log(error.toString(), name: "listTileTap");
    } finally {
      AppPopups.cancelDialog();
    }
  }

// Get Playlist
  Future<void> getPlaylist(Uri uri, String? videoId, int index) async {
    Uri? audio;
    try {
      // Clearing data
      await AudioHelper.player.stop();
      await AudioHelper.playlist.value.clear();
      home.playlistList.clear();

      // add song data
      await AudioHelper.playlist.value.add(
        AudioSource.uri(
          uri,
          tag: MediaItem(
            id: home.homeList.elementAt(index).videoId!,
            title: home.homeList.elementAt(index).title!,
          ),
        ),
      );
      await AudioHelper.player.setAudioSource(AudioHelper.playlist.value,
          initialIndex: 0, initialPosition: Duration.zero, preload: false);

      // playing song
      AudioHelper.player.play();

      // call api
      var response = await service.getPlaylist(videoId: videoId);
      List tracks = response.data["tracks"];
      home.playlistList.add(PlaylistModel.fromJson(tracks[0]));

      // go now play
      Get.find<BottomController>().bottom.selectedIndex.value = 1;
      AppPopups.cancelDialog();

      // add song to queue
      for (var i = 1; i < tracks.length; i++) {
        var id = tracks[i]["videoId"];

        audio = await AudioHelper.getAudioUri(videoId: id);
        if (audio == null) {
          throw Exception("getting audio failed");
        } else {
          home.playlistList.add(PlaylistModel.fromJson(tracks[i]));
          await AudioHelper.playlist.value.add(AudioSource.uri(
            audio,
            tag: MediaItem(
              id: home.playlistList.elementAt(i).videoId!,
              title: home.playlistList.elementAt(i).title!,
            ),
          ));
        }
      }
    } catch (error) {
      throw Exception();
    }
  }

  // Future<void> getOne({required String videoId, required int index}) async {
  //   // AudioSource? audioSource;
  //   try {
  //     var response = await service.getPlaylist(videoId: videoId);
  //     List tracks = response.data["tracks"];
  //     home.playlistList.add(PlaylistModel.fromJson(tracks[0]));
  //     log(home.playlistList.elementAt(0).title.toString(),
  //         name: "item in the 0 index of playlistList");
  //   } on DioException catch (dioError) {
  //     log(dioError.toString());
  //   } catch (error) {
  //     log(error.toString());
  //   } finally {}
  // }

  // Future<void> getAll({required String videoId}) async {
  //   AudioSource? audioSource;
  //   try {
  //     var response = await service.getPlaylist(videoId: videoId);
  //     List tracks = response.data["tracks"];
  //     for (int i = 1; i < tracks.length; i++) {
  //       var track = tracks[i];
  //       home.playlistList.add(PlaylistModel.fromJson(track));
  //     }
  //     for (var i = 1; i < home.playlistList.length; i++) {
  //       audioSource = await AudioHelper.getAudioSource(
  //           videoId: home.playlistList[i].videoId!);
  //       if (audioSource != null) {
  //         await home.playlist.value.add(audioSource);
  //       } else {
  //         throw Exception("Getting Audio Source Exception");
  //       }
  //     }
  //     // AudioHelper.player.setAudioSource(home.playlist.value,
  //     //     initialIndex: 1, initialPosition: Duration.zero, preload: false);
  //     // log(home.playlistList.elementAt(0).title.toString(),
  //     //     name: "item in the 0 index of playlistList");
  //   } on DioException catch (dioError) {
  //     log(dioError.toString());
  //   } catch (error) {
  //     log(error.toString());
  //   } finally {}
  // }

//   // Listen position stream
//   void listenPosition() {
//     AudioHelper.player.positionStream.listen((position) {
//       home.position.value = position;
//     });
//   }

// // List duration stream
//   void listenDuration() {
//     AudioHelper.player.durationStream.listen((duration) {
//       home.duration.value = duration!;
//     });
//   }

// // Method for playing song when ther user pressed the listtile
//   Future<void> play({required int index}) async {
//     try {
//       AppPopups.showDialog();
//       await AudioHelper.player.stop();
//       await AudioHelper.player.setAudioSource(
//         home.playlist,
//         initialIndex: index,
//         initialPosition: Duration.zero,
//       );
//       AudioHelper.player.play();
//     } catch (error) {
//       log(error.toString());
//     } finally {
//       AppPopups.cancelDialog();
//     }
//   }

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
