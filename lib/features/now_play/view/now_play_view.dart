import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/now_play/view/widgets/duration_text_error_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/duration_text_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/image_error_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/image_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/play_error_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/queue_container.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class NowPlayView extends StatelessWidget {
  const NowPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image of the Current Playing Song.
              StreamBuilder(
                stream: AudioHelper.player.currentIndexStream,
                builder: (_, currentIndexSnapshot) {
                  if (currentIndexSnapshot.hasError) {
                    return const ImageErrorWidget();
                  } else {
                    return Obx(
                      () => ImageWidget(
                        url: AudioHelper.playlistList
                            .elementAt(currentIndexSnapshot.data!)
                            .thumbnail!
                            .last
                            .url
                            .toString(),
                      ),
                    );
                  }
                },
              ),
              //-----------------------------------------
              AppSpacing.gapH20,
              //Name of the Current Playing Song.
              StreamBuilder(
                stream: AudioHelper.player.currentIndexStream,
                builder: (_, currentIndexSnapshot) {
                  if (currentIndexSnapshot.hasError) {
                    return const Text(AppTexts.kLoading);
                  } else {
                    return Obx(
                      () => Text(
                        AudioHelper.playlistList
                            .elementAt(currentIndexSnapshot.data!)
                            .title
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                },
              ),
              // ------------------------------------------------
              AppSpacing.gapH8,
              //Slider For Controlling the Current Song.
              StreamBuilder(
                stream: AudioHelper.player.durationStream,
                builder: (_, currentDurationStream) {
                  if (currentDurationStream.hasError) {
                    return CupertinoSlider(
                      value: 0.1,
                      onChanged: (_) {},
                    );
                  } else {
                    return StreamBuilder(
                      stream: AudioHelper.player.positionStream,
                      builder: (_, currentPositionStream) {
                        if (currentPositionStream.hasError) {
                          return const SizedBox.shrink();
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: CupertinoSlider(
                              min: const Duration(microseconds: 0)
                                  .inSeconds
                                  .toDouble(),
                              max: currentDurationStream.data?.inSeconds
                                      .toDouble() ??
                                  1.0,
                              value: currentPositionStream.data?.inSeconds
                                      .toDouble() ??
                                  0.5,
                              onChanged: ((value) {
                                AudioHelper.player.seek(
                                  Duration(seconds: value.toInt()),
                                );
                              }),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
              // ------------------------------------------------------
              AppSpacing.gapH8,
              //Text To Display Duration and Current Position of the Playing Song.

              StreamBuilder(
                stream: AudioHelper.player.durationStream,
                builder: (_, currentDurationStream) {
                  if (currentDurationStream.hasError) {
                    return const DurationTextErrorWidget();
                  } else {
                    AudioHelper.duration =
                        currentDurationStream.data ?? Duration.zero;
                    return StreamBuilder(
                      stream: AudioHelper.player.positionStream,
                      builder: (_, currentPositionStream) {
                        if (currentPositionStream.hasData) {
                          AudioHelper.position =
                              currentPositionStream.data ?? Duration.zero;

                          return DurationTextWidget(
                            positionData:
                                AudioHelper.position.toString().substring(2, 7),
                            durationData:
                                AudioHelper.duration.toString().substring(2, 7),
                          );
                        } else {
                          return const DurationTextErrorWidget();
                        }
                      },
                    );
                  }
                },
              ),

              // -------------------------------------------------------------
              AppSpacing.gapH28,
              //Buttons To Control The Music PlayBack.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Shuffle Button.
                  StreamBuilder<bool>(
                    stream: AudioHelper.player.shuffleModeEnabledStream,
                    builder: (context, currentShuffleModeEnabledStream) {
                      if (currentShuffleModeEnabledStream.hasError) {
                        return const Icon(Icons.error_outline_rounded);
                      } else {
                        final isShuffle = currentShuffleModeEnabledStream.data;
                        if (isShuffle == true) {
                          return GestureDetector(
                            onTap: () {
                              AudioHelper.player
                                  .setShuffleModeEnabled(false)
                                  .then(
                                    (_) => Get.snackbar(
                                      snackPosition: SnackPosition.BOTTOM,
                                      'ദാസപ്പൻ',
                                      'Shuffle off.',
                                    ),
                                  );
                            },
                            child: const Icon(
                              Icons.shuffle_on_rounded,
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              AudioHelper.player
                                  .setShuffleModeEnabled(true)
                                  .then(
                                    (_) => Get.snackbar(
                                      snackPosition: SnackPosition.BOTTOM,
                                      'ദാസപ്പൻ',
                                      'Shuffle on.',
                                    ),
                                  );
                            },
                            child: const Icon(
                              Icons.shuffle_rounded,
                            ),
                          );
                        }
                      }
                    },
                  ),
//-------------------------------
                  // Previous Button.
                  GestureDetector(
                    onTap: () {
                      if (AudioHelper.player.hasPrevious) {
                        AudioHelper.player.seekToPrevious();
                      }
                    },
                    child: const Icon(Icons.skip_previous_rounded),
                  ),
                  //-------------------------------

                  //Play Pause Button.
                  StreamBuilder(
                    stream: AudioHelper.player.playerStateStream,
                    builder: (_, currentPlayerStateSnapshot) {
                      if (currentPlayerStateSnapshot.hasError) {
                        return const PlayErrorWidget();
                      } else {
                        return PlayPauseWidget(
                            playerState: currentPlayerStateSnapshot.data);
                      }
                    },
                  ),
                  // -------------------------------
                  // Next Button.
                  GestureDetector(
                    onTap: () {
                      if (AudioHelper.player.hasNext) {
                        AudioHelper.player.seekToNext();
                      }
                    },
                    child: const Icon(Icons.skip_next_rounded),
                  ),
                  //-------------------------------
                  //Shuffle Button.
                  StreamBuilder(
                    stream: AudioHelper.player.loopModeStream,
                    builder: (_, currentLoopModeStreamSnapshot) {
                      if (currentLoopModeStreamSnapshot.hasError) {
                        return const Icon(Icons.error_outline_rounded);
                      } else {
                        final loopMode = currentLoopModeStreamSnapshot.data;
                        if (loopMode == LoopMode.off) {
                          return GestureDetector(
                            onTap: () {
                              AudioHelper.player.setLoopMode(LoopMode.one).then(
                                    (_) => Get.snackbar(
                                      snackPosition: SnackPosition.BOTTOM,
                                      'ദാസപ്പൻ',
                                      'Repeat on.',
                                    ),
                                  );
                            },
                            child: const Icon(
                              Icons.repeat_rounded,
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              AudioHelper.player.setLoopMode(LoopMode.off).then(
                                    (_) => Get.snackbar(
                                      snackPosition: SnackPosition.BOTTOM,
                                      'ദാസപ്പൻ',
                                      'Repeat off.',
                                    ),
                                  );
                            },
                            child: const Icon(
                              Icons.repeat_one_rounded,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  // ----------------------------------------------------------
                ],
              ),
              // -------------------------------------------------------------
              AppSpacing.gapH32,
              // Button to show Music Queue.
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    const QueueContainer(),
                    ignoreSafeArea: true,
                    isScrollControlled: true,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: [
                        const Icon(Icons.queue_music_rounded),
                        Text(
                          'Music Queue',
                          style: TextStyle(fontSize: 8.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // -----------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
