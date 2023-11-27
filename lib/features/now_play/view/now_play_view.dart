import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';

import 'package:music_stream/features/now_play/view/widgets/now_button.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_button.dart';
import 'package:music_stream/features/now_play/view/widgets/queue_container.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/general_widgets.dart/bg.dart';

import 'package:music_stream/utils/helpers/audio_helper.dart';

class NowPlayView extends StatefulWidget {
  const NowPlayView({super.key});

  @override
  State<NowPlayView> createState() => _NowPlayViewState();
}

class _NowPlayViewState extends State<NowPlayView> {
  @override
  Widget build(BuildContext context) {
    // bool _isShuffle = false;
    // final homeController = Get.put(HomeController());
    return Bg(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: pc.close,
            icon: Icon(
              Icons.expand_more_rounded,
              color: pc.isPanelOpen ? AppColors.kWhite : Colors.transparent,
            ),
          ),
          actions: [
            pc.isPanelOpen
                ? MenuAnchor(
                    style: MenuStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          AppColors.kWhite),
                      elevation: const MaterialStatePropertyAll<double>(0),
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.only(right: 10.w)),
                    ),
                    builder: (context, controller, child) {
                      return IconButton(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const Icon(Icons.more_vert_rounded),
                        // tooltip: 'Show menu',
                      );
                    },
                    menuChildren: List<MenuItemButton>.generate(
                      1,
                      (int index) => MenuItemButton(
                        onPressed: () {
                          Get.bottomSheet(
                            const QueueContainer(),
                          );
                        },
                        leadingIcon: const Icon(
                          Icons.queue_music_rounded,
                          color: AppColors.kBlack,
                        ),
                        // style: ButtonStyle(
                        //   backgroundColor:
                        //       MaterialStatePropertyAll<Color>(Colors.green),
                        // ),
                        child: Text(
                          'Show queue',
                          style: AppTypography.kRegular13,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: StreamBuilder(
              stream: AudioHelper.player.currentIndexStream,
              builder: (context, currentIndex) {
                if (currentIndex.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (AudioHelper.playlistList.isNotEmpty) ...[
                      Obx(
                        () => FadeInImage(
                          placeholder: AssetImage(
                            AppAssets.kLenin,
                          ),
                          image: NetworkImage(
                            AudioHelper.playlistList
                                .elementAt(currentIndex.data!)
                                .thumbnail!
                                .last
                                .url
                                .toString(),
                          ),
                          width: 380.w,
                          height: 380.w,
                          fit: BoxFit.fill,
                          placeholderFit: BoxFit.fill,
                        ),
                      ),

                      AppSpacing.gapH40,
                      Obx(
                        () => Text(
                          AudioHelper.playlistList
                              .elementAt(currentIndex.data!)
                              .title
                              .toString(),
                          style: AppTypography.kSecondary,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpacing.gapH20,
                      // Obx(
                      //   () => Row(
                      //     children: [
                      //       Text(
                      //         _homeController.home.position.toString().substring(2, 7),
                      //         style: AppTypography.kBold12
                      //             .copyWith(color: AppColors.kWhite500),
                      //       ),
                      //       Expanded(
                      //         child: CupertinoSlider(
                      //           min: 0,
                      //           max: 10,
                      //           value: 5,
                      //           activeColor: AppColors.kWhite,
                      //           onChanged: ((value) {
                      //             AudioHelper.player.seek(
                      //               Duration(seconds: value.toInt()),
                      //             );
                      //           }),
                      //         ),
                      //       ),
                      //       Text(
                      //         _homeController.home.duration.toString().substring(2, 7),
                      //         style: AppTypography.kBold12
                      //             .copyWith(color: AppColors.kWhite500),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      StreamBuilder(
                          stream: AudioHelper.player.durationStream,
                          builder: (context, durationSnapshot) {
                            if (durationSnapshot.hasData) {
                              AudioHelper.duration = durationSnapshot.data!;
                              return StreamBuilder(
                                stream: AudioHelper.player.positionStream,
                                builder: (context, positionSnapshot) {
                                  if (positionSnapshot.hasData) {
                                    AudioHelper.position =
                                        positionSnapshot.data!;
                                    return Row(
                                      children: [
                                        Text(
                                          AudioHelper.position
                                              .toString()
                                              .substring(2, 7),
                                          style: AppTypography.kSecondary
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                        Expanded(
                                          child: CupertinoSlider(
                                            min: const Duration(microseconds: 0)
                                                .inSeconds
                                                .toDouble(),
                                            max: AudioHelper.duration.inSeconds
                                                .toDouble(),
                                            value: AudioHelper
                                                .position.inSeconds
                                                .toDouble(),

                                            activeColor: AppColors.kWhite,
                                            onChanged: ((value) {
                                              AudioHelper.player.seek(
                                                Duration(
                                                    seconds: value.toInt()),
                                              );
                                            }),

                                            // activeColor: Colors.white,

                                            // inactiveColor: Colors.white.withOpacity(0.3),
                                            // thumbColor: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          AudioHelper.duration
                                              .toString()
                                              .substring(2, 7),
                                          style: AppTypography.kSecondary
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                      AppSpacing.gapH52,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Experimenting shuffle and repeat.
                          StreamBuilder<bool>(
                            stream: AudioHelper.player.shuffleModeEnabledStream,
                            builder: (context, snapshot) {
                              final isShuffle = snapshot.data;
                              if (isShuffle == true) {
                                return NowButton(
                                  size: 25.h,
                                  icon: Icons.shuffle_on_rounded,
                                  onPressed: () {
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
                                );
                              } else {
                                return NowButton(
                                  size: 25.h,
                                  icon: Icons.shuffle_rounded,
                                  onPressed: () {
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
                                );
                              }
                            },
                          ),
                          NowButton(
                            icon: Icons.skip_previous_rounded,
                            onPressed: () {
                              if (AudioHelper.player.hasPrevious) {
                                AudioHelper.player.seekToPrevious();
                              }
                            },
                          ),
                          // NowButton(
                          //   icon: AudioHelper.player.playing
                          //       ? CupertinoIcons.pause_fill
                          //       : CupertinoIcons.play_fill,
                          //   onPressed: () {
                          //     if (AudioHelper.player.playing) {
                          //       AudioHelper.player.pause();
                          //     } else {
                          //       AudioHelper.player.play();
                          //     }
                          //   },
                          // ),
                          StreamBuilder<PlayerState>(
                            stream: AudioHelper.player.playerStateStream,
                            builder: (_, snapshot) {
                              final playerState = snapshot.data;
                              return Container(
                                width: 70.w,
                                height: 70.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.kGreen,
                                ),
                                child:
                                    PlayPauseButton(playerState: playerState),
                              );
                            },
                          ),
                          NowButton(
                            icon: Icons.skip_next_rounded,
                            onPressed: () {
                              if (AudioHelper.player.hasNext) {
                                AudioHelper.player.seekToNext();
                              }
                            },
                          ),

                          ///Experimenting shuffle and repeat.
                          StreamBuilder<LoopMode>(
                            stream: AudioHelper.player.loopModeStream,
                            builder: (context, snapshot) {
                              final loopMode = snapshot.data;
                              if (loopMode == LoopMode.off) {
                                return NowButton(
                                  size: 25.h,
                                  icon: Icons.repeat_rounded,
                                  onPressed: () {
                                    AudioHelper.player
                                        .setLoopMode(LoopMode.one)
                                        .then(
                                          (_) => Get.snackbar(
                                            snackPosition: SnackPosition.BOTTOM,
                                            'ദാസപ്പൻ',
                                            'Repeat on.',
                                          ),
                                        );
                                  },
                                );
                              } else {
                                return NowButton(
                                  size: 25.h,
                                  icon: Icons.repeat_one_rounded,
                                  onPressed: () {
                                    AudioHelper.player
                                        .setLoopMode(LoopMode.off)
                                        .then(
                                          (_) => Get.snackbar(
                                            snackPosition: SnackPosition.BOTTOM,
                                            'ദാസപ്പൻ',
                                            'Repeat off.',
                                          ),
                                        );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ]

                    // AppSpacing.gapH52,
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(CupertinoIcons.volume_down),
                    //     ),
                    //     Expanded(
                    //       child: CupertinoSlider(
                    //         // min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    //         // max: 1,
                    //         // value: 10,
                    //         min: 0,
                    //         max: 100,

                    //         value: 10,
                    //         activeColor: AppColors.kWhite,
                    //         onChanged: ((value) {
                    //           // setState(() {
                    //           //   changeToSeconds(value.toInt());
                    //           //   value = value;
                    //           // });
                    //           // provider.onChanged(value);
                    //         }),
                    //         // activeColor: Colors.white,

                    //         // inactiveColor: Colors.white.withOpacity(0.3),
                    //         // thumbColor: Colors.white,
                    //       ),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(CupertinoIcons.volume_up),
                    //     ),
                    //   ],
                    // ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
