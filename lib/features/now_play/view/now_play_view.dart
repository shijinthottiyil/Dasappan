import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/now_play/view/widgets/now_button.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_button.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';
import 'package:music_stream/utils/helpers/exit_app.dart';

class NowPlayView extends StatelessWidget {
  NowPlayView({super.key});
  final _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: exitApp,
      child: Scaffold(
        body: SafeArea(
          child: AudioHelper.playlistList.isEmpty
              ? Center(
                  child: Text(
                    "Not selected any song!",
                    style: AppTypography.kExtraBold24,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: StreamBuilder(
                      stream: AudioHelper.player.currentIndexStream,
                      builder: (context, currentIndex) {
                        if (currentIndex.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => ClipRRect(
                                borderRadius: BorderRadius.circular(8).r,
                                child: FadeInImage(
                                  placeholder: AssetImage(
                                    AppAssets.kNowplay,
                                  ),
                                  image: NetworkImage(
                                    AudioHelper.playlistList.isEmpty
                                        ? AudioHelper.playlistList
                                            .elementAt(0)
                                            .thumbnail!
                                            .last
                                            .url
                                            .toString()
                                        : AudioHelper.playlistList
                                            .elementAt(currentIndex.data!)
                                            .thumbnail!
                                            .last
                                            .url
                                            .toString(),
                                  ),
                                  width: 293.w,
                                  height: 270.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            AppSpacing.gapH100,
                            Obx(
                              () => Text(
                                AudioHelper.playlistList.isEmpty
                                    ? "Sia_-_Chandelier"
                                    : AudioHelper.playlistList
                                        .elementAt(currentIndex.data!)
                                        .title
                                        .toString(),
                                style: AppTypography.kBold24,
                              ),
                            ),
                            AppSpacing.gapH52,
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
                                    AudioHelper.duration =
                                        durationSnapshot.data!;
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
                                                style: AppTypography.kBold12
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhite500),
                                              ),
                                              Expanded(
                                                child: CupertinoSlider(
                                                  min: const Duration(
                                                          microseconds: 0)
                                                      .inSeconds
                                                      .toDouble(),
                                                  max: AudioHelper
                                                      .duration.inSeconds
                                                      .toDouble(),
                                                  value: AudioHelper
                                                      .position.inSeconds
                                                      .toDouble(),

                                                  activeColor: AppColors.kWhite,
                                                  onChanged: ((value) {
                                                    AudioHelper.player.seek(
                                                      Duration(
                                                          seconds:
                                                              value.toInt()),
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
                                                style: AppTypography.kBold12
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhite500),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                NowButton(
                                  icon: CupertinoIcons.backward_fill,
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
                                    return PlayPauseButton(
                                        playerState: playerState);
                                  },
                                ),
                                NowButton(
                                  icon: CupertinoIcons.forward_fill,
                                  onPressed: () {
                                    if (AudioHelper.player.hasNext) {
                                      AudioHelper.player.seekToNext();
                                    }
                                  },
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
