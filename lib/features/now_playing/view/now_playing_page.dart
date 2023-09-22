import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/controller/music_controller.dart';
import 'package:music_stream/features/home/controller/home_provider.dart';
import 'package:music_stream/features/now_playing/controller/now_play_provider.dart';
import 'package:music_stream/utils/loader.dart';

class NowPlayingPage extends ConsumerWidget {
  const NowPlayingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final provider = ref.watch(homePageProvider);
    final nowPlayProvider = ref.watch(nowProvider);
    // final musicProvider = ref.watch(searchProvider);

    // var currentIndex = 0;
    // MusicController.player.currentIndexStream.listen((index) {
    //   currentIndex = index!;
    // });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder(
              stream: MusicController.player.currentIndexStream,
              builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                }
                return Column(
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
                              provider.playingSongModelList
                                  .elementAt(snapshot.data!)
                                  .thumbnails,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  provider.playingSongModelList
                                      .elementAt(snapshot.data!)
                                      .thumbnails,
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
                            provider.playingSongModelList
                                .elementAt(snapshot.data!)
                                .title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 24,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Text(
                            provider.playingSongModelList
                                .elementAt(snapshot.data!)
                                .artists,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          ),
                          StreamBuilder(
                              stream: MusicController.player.durationStream,
                              builder: (context, durationSnapshot) {
                                if (durationSnapshot.hasData) {
                                  MusicController.duration =
                                      durationSnapshot.data!;
                                  return StreamBuilder(
                                      stream:
                                          MusicController.player.positionStream,
                                      builder: (context, positionSnapshot) {
                                        if (positionSnapshot.hasData) {
                                          MusicController.position =
                                              positionSnapshot.data!;
                                          return Row(
                                            children: [
                                              Text(
                                                MusicController.position
                                                    .toString()
                                                    .substring(2, 7),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Expanded(
                                                child: CupertinoSlider(
                                                  min: const Duration(
                                                          microseconds: 0)
                                                      .inSeconds
                                                      .toDouble(),
                                                  max: MusicController
                                                      .duration.inSeconds
                                                      .toDouble(),
                                                  value: MusicController
                                                      .position.inSeconds
                                                      .toDouble(),

                                                  activeColor: Colors.white,
                                                  onChanged: ((value) {
                                                    MusicController.player.seek(
                                                      Duration(
                                                        seconds: value.toInt(),
                                                      ),
                                                    );
                                                  }),
                                                  // activeColor: Colors.white,

                                                  // inactiveColor: Colors.white.withOpacity(0.3),
                                                  // thumbColor: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                MusicController.duration
                                                    .toString()
                                                    .substring(2, 7),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      });
                                } else {
                                  return Container();
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: (() {
                                  MusicController.player.shuffleModeEnabled ==
                                          true
                                      ? MusicController.player
                                          .setShuffleModeEnabled(false)
                                      : MusicController.player
                                          .setShuffleModeEnabled(true);
                                }),
                                icon: StreamBuilder<bool>(
                                  stream: MusicController
                                      .player.shuffleModeEnabledStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data as bool) {
                                        return Icon(
                                          CupertinoIcons.shuffle,
                                        );
                                      } else {
                                        return const Icon(
                                          CupertinoIcons.shuffle,
                                          color: Colors.grey,
                                        );
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: provider.previous,
                                onDoubleTap: provider.fastBackward,
                                child: Icon(CupertinoIcons.backward_fill),
                              ),
                              IconButton(
                                onPressed: provider.playOrPause,
                                icon: Column(
                                  children: [
                                    if (MusicController.player.playing) ...[
                                      Icon(CupertinoIcons.pause_fill)
                                    ] else if (!MusicController
                                        .player.playing) ...[
                                      Icon(CupertinoIcons.play_fill)
                                    ],
                                    // Icon(CupertinoIcons.pause_fill),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: provider.next,
                                onDoubleTap: provider.fastForward,
                                child: Icon(CupertinoIcons.forward_fill),
                              ),
                              IconButton(
                                onPressed: (() {
                                  MusicController.player.loopMode ==
                                          LoopMode.off
                                      ? MusicController.player
                                          .setLoopMode(LoopMode.one)
                                      : MusicController.player
                                          .setLoopMode(LoopMode.off);
                                }),
                                icon: StreamBuilder<LoopMode>(
                                  stream: MusicController.player.loopModeStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      final loopMode = snapshot.data;
                                      if (loopMode == LoopMode.off) {
                                        return Icon(
                                          CupertinoIcons.repeat,
                                        );
                                      } else {
                                        return Icon(
                                          CupertinoIcons.repeat_1,
                                        );
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: MusicController.player.volumeStream,
                      builder: (context, volumeSnapShot) {
                        if (volumeSnapShot.hasData) {
                          return Row(
                            children: [
                              volumeSnapShot.data == 0.0
                                  ? Icon(CupertinoIcons.volume_off)
                                  : Icon(CupertinoIcons.volume_down),
                              Expanded(
                                child: CupertinoSlider(
                                  min: 0.0,
                                  max: 1.0,
                                  value: provider.currentVolume,
                                  onChanged: (value) {
                                    provider.controlVolume(value);
                                  },
                                ),
                              ),
                              Icon(CupertinoIcons.volume_up),
                            ],
                          );
                        } else {
                          return Loader();
                        }
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: IconButton(
          onPressed: () {
            nowPlayProvider.getModelSheet(context: context);
          },
          icon: Icon(CupertinoIcons.music_albums)),
    );
  }
}
