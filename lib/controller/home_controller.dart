import 'dart:developer';
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/controller/search_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;

final homeProvider = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

class HomeController with ChangeNotifier {
  final textController = TextEditingController();
  var isLoading = false;

  Future<void> covert(BuildContext context, WidgetRef ref) async {
    final yt = YoutubeExplode();

    try {
      final id = VideoId(textController.text.trim());
      isLoading = true;
      notifyListeners();
      await yt.videos.get(id).then(
        (value) {
          isLoading = false;
          notifyListeners();
          AwesomeDialog(context: context);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Success',
            desc: 'Ok to continue',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              store(yt: yt, id: id, video: value, context: context, ref: ref);
            },
          ).show();
        },
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Uh oh',
        desc: 'Error occured',
        btnOkOnPress: () {},
      ).show();
    }
  }

// Method to Store file
  Future<void> store(
      {required YoutubeExplode yt,
      required VideoId id,
      required dynamic video,
      required context,
      required WidgetRef ref}) async {
    var status = await Permission.storage.status;

    log(status.toString());
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final manifest = await yt.videos.streamsClient.getManifest(id);

    final audio = manifest.audioOnly.withHighestBitrate();
    final audioStream = yt.videos.streamsClient.get(audio);

    final dir = await AndroidPathProvider.downloadsPath;
    final filePath = path.join(
      dir,
      '${video.id}.mp3',
    );

    final file = File(filePath);

    // Delete The File If Exists
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Open the file in writeAppened.
    final output = file.openWrite(mode: FileMode.writeOnlyAppend);

// Track the file download status.
    final len = audio.size.totalBytes;
    var count = 0.0;

// Listen for data received.
    await for (final data in audioStream) {
      count += data.length;
      final progress = ((count / len) * 100).ceil();
      // ref.watch(downloadProgressProvider.notifier).updateProgress(progress);
      output.add(data);
    }
    await output.flush();
    await output.close();
    // textController.clear();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: 'Download completed and saved to: $filePath',
    ).show();
    // AwesomeDialog(
    //   context: context,
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Consumer(
    //           builder: (context, ref, child) {
    //             final downloadProgress = ref.watch(downloadProgressProvider);
    //             return Column(
    //               children: [
    //                 LinearProgressIndicator(
    //                   value: downloadProgress / 100.0,
    //                 ),
    //                 Text('${downloadProgress.toStringAsFixed(2)}%'),
    //               ],
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // ).show();

    // await for (final data in audioStream) {
    //   // Keep track of the current downloaded data.
    //   count += data.length;
    //   // Calculate the current progress.
    //   final progress = ((count / len) * 100).ceil();
    //   log(progress.toString());
    //   output.add(data);
    // }
    // await output.close();

    //<------------------ Older Version --------------------->

    // final fileStream = file.openWrite();
    // final audioStream = yt.videos.streamsClient.get(audio);
    // var count = 0.0;
    // await for (final data in audioStream) {
    //   count += data.length;
    //   log(count.toString());
    // }
    // await fileStream.flush();
    // await fileStream.close();
    // textController.clear();
    // // textController.dispose();

    // AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.success,
    //   animType: AnimType.rightSlide,
    //   title: 'Success',
    //   desc: 'Download completed and saved to: $filePath',
    //   btnOkOnPress: () {},
    // ).show();
  }

  // <============ MOCK METHOD TO PLAYLIST ===============>
  mock() async {
    var yt = YoutubeExplode();
    // var playlistUrl =
    //     "https://www.youtube.com/watch?v=OiC1rgCPmUQ&list=PLMC9KNkIncKtGvr2kFRuXBVmBev6cAJ2u";
    // final id = PlaylistId(playlistUrl);

    // var playlist = await yt.playlists.get(id);

    // await for (var video in yt.playlists.getVideos(playlist.id).take(10)) {
    //   log(video.title);
    //   log(video.author);
    // }
    // log(playlist.title);
    // log(playlist.author);

    var audioUrl = "";
    final id = VideoId("https://www.youtube.com/watch?v=RVLNBVK8auM");
    final StreamManifest manifest =
        await yt.videos.streamsClient.getManifest(id);
    audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();

    final player = AudioPlayer();
    await player.setUrl(audioUrl);
    player.pause();
  }
}
