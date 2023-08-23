import 'dart:developer';
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;

final homeProvider = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

class HomeController with ChangeNotifier {
  final textController = TextEditingController();
  var isLoading = false;

  covert(BuildContext context) async {
    final yt = YoutubeExplode();

    try {
      final id = VideoId(textController.text.trim());
      isLoading = true;
      notifyListeners();
      final video = await yt.videos.get(id).then(
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
              store(yt: yt, id: id, video: value, context: context);
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
  store(
      {required YoutubeExplode yt,
      required VideoId id,
      required dynamic video,
      required context}) async {
    var status = await Permission.storage.status;

    log(status.toString());
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final manifest = await yt.videos.streamsClient.getManifest(id);

    final audio = manifest.audioOnly.withHighestBitrate();

    final dir = await AndroidPathProvider.downloadsPath;
    final filePath = path.join(
      dir,
      '${video.id}.mp3',
    );

    final file = File(filePath);
    final fileStream = file.openWrite();
    await yt.videos.streamsClient.get(audio).pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();
    textController.clear();
    // textController.dispose();

    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: 'Download completed and saved to: $filePath',
      btnOkOnPress: () {},
    ).show();
  }
}
