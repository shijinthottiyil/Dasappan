import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/controller/home_controller.dart';
import 'package:music_stream/controller/music_controller.dart';
import 'package:music_stream/controller/search_controller.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class NowPlayingScreen extends ConsumerWidget {
  const NowPlayingScreen({
    super.key,
    required this.url,
    required this.title,
    required this.artist,
    required this.videoId,
  });
  final String url;
  final String title;
  final String artist;
  // videoId variable is used for downloading

  final String videoId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final provider = ref.watch(searchProvider);
    // final homeProvi = ref.watch(homeProvider);
    final progressProvider = ref.watch(downloadProgressProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: width / 1.5,
                  height: height / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      url,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          url,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        );
                      },
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: height / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 24,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    artist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        provider.position.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: CupertinoSlider(
                          min: const Duration(microseconds: 0)
                              .inSeconds
                              .toDouble(),
                          max: provider.duration.inSeconds.toDouble(),
                          value: provider.position.inSeconds.toDouble(),
                          activeColor: Colors.white,
                          onChanged: ((value) {
                            // setState(() {
                            //   changeToSeconds(value.toInt());
                            //   value = value;
                            // });
                            provider.onChanged(value);
                          }),
                          // activeColor: Colors.white,

                          // inactiveColor: Colors.white.withOpacity(0.3),
                          // thumbColor: Colors.white,
                        ),
                      ),
                      Text(
                        provider.duration.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.shuffle),
                      ),
                      IconButton(
                        onPressed: provider.fastBackward,
                        icon: Icon(CupertinoIcons.backward_fill),
                      ),
                      IconButton(
                        onPressed: provider.playOrPause,
                        icon: Column(
                          children: [
                            if (provider.player.playing) ...[
                              Icon(CupertinoIcons.pause_fill)
                            ] else if (!provider.player.playing) ...[
                              Icon(CupertinoIcons.play_fill)
                            ]
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: provider.fastForward,
                        icon: Icon(CupertinoIcons.forward_fill),
                      ),
                      IconButton(
                        onPressed: () {
                          // homeProvi.store(
                          //     yt: provider.yt,
                          //     id: VideoId(
                          //         provider.searchModelList.first.videoId),
                          //     video: provider.searchModelList.first.videoId,
                          //     context: context,
                          //     ref: ref);
                          provider.downloadSongs(videoId: videoId, ref: ref);
                        },
                        icon: Column(
                          children: [
                            if (!provider.isDownloadStarted) ...[
                              Icon(CupertinoIcons.arrow_down_to_line_alt)
                            ] else if (provider.isDownloadStarted) ...[
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Center(
                                      child: CircularProgressIndicator(
                                        value: progressProvider / 100,
                                        backgroundColor: Colors.white,
                                        strokeWidth: 6,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.black),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "$progressProvider%",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                provider.currentVolume == provider.minVolume
                    ? Icon(CupertinoIcons.volume_off)
                    : Icon(CupertinoIcons.volume_down),
                Expanded(
                  child: CupertinoSlider(
                    min: provider.minVolume,
                    max: provider.maxVolume,
                    value: provider.currentVolume,
                    onChanged: (value) {
                      provider.controlVolume(value);
                    },
                  ),
                ),
                Icon(CupertinoIcons.volume_up),
              ],
            )
          ],
        ),
      )),
    );
  }
}
