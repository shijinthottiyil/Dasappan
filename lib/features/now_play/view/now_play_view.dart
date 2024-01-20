import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/favorites/controller.dart/favorite_controller.dart';
import 'package:music_stream/features/favorites/model/favorite_model.dart';
import 'package:music_stream/features/now_play/view/widgets/duration_text_error_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/duration_text_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/image_error_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/image_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/play_error_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/queue_container.dart';
import 'package:music_stream/utils/logic/database/database_manager.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/logic/networking/networking.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

class NowPlayView extends StatelessWidget {
  const NowPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteC = Get.find<FavoriteController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Obx(
            () => AudioHelper.playlistList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Image of the Current Playing Song.
                      StreamBuilder(
                        stream: AudioHelper.player.currentIndexStream,
                        builder: (_, currentIndexSnapshot) {
                          if (currentIndexSnapshot.hasData) {
                            return Obx(
                              () => ImageLoaderWidget(
                                borderRadius: BorderRadius.circular(10.r),
                                imageUrl: AudioHelper.playlistList
                                    .elementAt(currentIndexSnapshot.data!)
                                    .thumbnail!
                                    .last
                                    .url
                                    .toString(),
                                width: double.infinity,
                                height: 380.w,
                                fit: BoxFit.fill,
                              ),
                            );
                          } else {
                            return const ImageErrorWidget();
                          }
                        },
                      ),
                      //-----------------------------------------
                      AppSpacing.gapH20,
                      //Name of the Current Playing Song. and Favorite Button
                      StreamBuilder(
                        stream: AudioHelper.player.currentIndexStream,
                        builder: (_, currentIndexSnapshot) {
                          if (currentIndexSnapshot.hasData) {
                            final currentSongData = AudioHelper.playlistList
                                .elementAt(currentIndexSnapshot.data!);

                            return Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => Text(
                                      AudioHelper.playlistList
                                          .elementAt(currentIndexSnapshot.data!)
                                          .title
                                          .toString(),
                                      style: AppTypography.kBold24,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => GestureDetector(
                                    onTap: () async {
                                      //Add To Favorites
                                      if (!favoriteC.variables.favoriteDbIdsList
                                          .contains(currentSongData.videoId)) {
                                        await DatabaseManager.addToFavorite(
                                            currentSongData);
                                        favoriteC.addFavoriteIds(
                                            videoId: currentSongData.videoId!);
                                      }
                                      //Remove From Favorites
                                      else {
                                        await DatabaseManager
                                            .deleteFromFavorite(
                                                id: currentSongData.videoId!);
                                        favoriteC.deleteFavoriteIds(
                                            videoId: currentSongData.videoId!);
                                      }
                                    },
                                    child: Container(
                                      width: 50.w,
                                      height: 50.w,
                                      decoration: BoxDecoration(
                                        color: context.isDarkMode
                                            ? AppColors.kWhite
                                            : AppColors.kBlack,
                                        shape: BoxShape.circle,
                                      ),
                                      child: favoriteC
                                              .variables.favoriteDbIdsList
                                              .contains(currentSongData.videoId)
                                          ? const Icon(
                                              Icons.favorite_rounded,
                                              // color: context.isDarkMode
                                              //     ? AppColors.kBlack
                                              //     : AppColors.kWhite,
                                              color: Colors.redAccent,
                                            )
                                          : Icon(
                                              Icons.favorite_border_rounded,
                                              color: context.isDarkMode
                                                  ? AppColors.kBlack
                                                  : AppColors.kWhite,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Text(AppTexts.kLoading);
                          }
                        },
                      ),
                      // ------------------------------------------------
                      // AppSpacing.gapH8,
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
                                if (currentPositionStream.hasData) {
                                  return SliderTheme(
                                    data: SliderThemeData(
                                        trackShape: CustomTrackShape()),
                                    child: Slider(
                                      min: const Duration(microseconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: currentDurationStream.data?.inSeconds
                                              .toDouble() ??
                                          1.0,
                                      value: currentPositionStream
                                              .data?.inSeconds
                                              .toDouble() ??
                                          0.5,
                                      onChanged: ((value) {
                                        AudioHelper.player.seek(
                                          Duration(seconds: value.toInt()),
                                        );
                                      }),
                                    ),
                                  );
                                  /* return CupertinoSlider(
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
                            );
                            */
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
                          }
                        },
                      ),
                      // ------------------------------------------------------
                      // AppSpacing.gapH8,
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
                                      currentPositionStream.data ??
                                          Duration.zero;

                                  return DurationTextWidget(
                                    positionData: AudioHelper.position
                                        .toString()
                                        .substring(2, 7),
                                    durationData: AudioHelper.duration
                                        .toString()
                                        .substring(2, 7),
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
                            builder:
                                (context, currentShuffleModeEnabledStream) {
                              if (currentShuffleModeEnabledStream.hasError) {
                                return const Icon(Icons.error_outline_rounded);
                              } else {
                                final isShuffle =
                                    currentShuffleModeEnabledStream.data;
                                if (isShuffle == true) {
                                  return GestureDetector(
                                    onTap: () {
                                      AudioHelper.player
                                          .setShuffleModeEnabled(false)
                                          .then(
                                            (_) => Get.snackbar(
                                              // snackPosition: SnackPosition.BOTTOM,
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
                                              // snackPosition: SnackPosition.BOTTOM,
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
                            child: const Icon(
                              Icons.skip_previous_rounded,
                              size: 36,
                            ),
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
                                    playerState:
                                        currentPlayerStateSnapshot.data);
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
                            child: const Icon(
                              Icons.skip_next_rounded,
                              size: 36,
                            ),
                          ),
                          //-------------------------------
                          //Shuffle Button.
                          StreamBuilder(
                            stream: AudioHelper.player.loopModeStream,
                            builder: (_, currentLoopModeStreamSnapshot) {
                              if (currentLoopModeStreamSnapshot.hasError) {
                                return const Icon(Icons.error_outline_rounded);
                              } else {
                                final loopMode =
                                    currentLoopModeStreamSnapshot.data;
                                if (loopMode == LoopMode.off) {
                                  return GestureDetector(
                                    onTap: () {
                                      AudioHelper.player
                                          .setLoopMode(LoopMode.one)
                                          .then(
                                            (_) => Get.snackbar(
                                              // snackPosition: SnackPosition.BOTTOM,
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
                                      AudioHelper.player
                                          .setLoopMode(LoopMode.off)
                                          .then(
                                            (_) => Get.snackbar(
                                              // snackPosition: SnackPosition.BOTTOM,
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
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}

//The Code below is used for removing the padding from the slider.If we use the Slider only it will have a default padding.
class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
// ------------------------------------------------------------------------------------------------------------------------.
