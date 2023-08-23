import 'dart:developer';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart' as ffmpeg;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CupertinoTextField(
              controller: textController,
            ),
            ElevatedButton(
              onPressed: () async {
                final yt = YoutubeExplode();
                final id = VideoId(textController.text.trim());
                final video = await yt.videos.get(id);

                await Permission.storage.request();

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

                // Convert .webm to .mp3 using FFmpeg
                // final mp3FilePath = path.join(
                //   dir,
                //   '${video.id}.mp3',
                // );

                // final ffmpegCommand =
                //     '-i "$filePath" -vn -acodec libmp3lame "$mp3FilePath"';

                // await ffmpeg.FFmpegKit.execute(ffmpegCommand).then((value) {
                //   log("success");
                // });

                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          Text('Download completed and saved to: $filePath'),
                    );
                  },
                );

                yt.close();
              },
              child: Text("Download and Convert"),
            ),
          ],
        ),
      ),
    );
  }
}
