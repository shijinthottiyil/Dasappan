import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

class PlayPauseWidget extends StatelessWidget {
  const PlayPauseWidget({super.key, required this.playerState});
  final PlayerState? playerState;
  @override
  Widget build(BuildContext context) {
    final processingState = playerState?.processingState;
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kGreen,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) ...[
            LoadingAnimationWidget.bouncingBall(
              color: AppColors.kWhite,
              size: 50.r,
            ),
          ] else if (AudioHelper.player.playing != true) ...[
            GestureDetector(
              onTap: AudioHelper.player.play,
              child: Icon(
                Icons.play_arrow_rounded,
                size: 56.h,
              ),
            ),
          ] else if (processingState != ProcessingState.completed) ...[
            GestureDetector(
              onTap: AudioHelper.player.pause,
              child: Icon(
                Icons.pause_rounded,
                size: 56.h,
              ),
            ),
          ] else ...[
            GestureDetector(
              onTap: () {
                AudioHelper.player.seek(
                  Duration.zero,
                  index: AudioHelper.player.effectiveIndices?.first,
                );
              },
              child: Icon(
                Icons.replay_rounded,
                size: 56.h,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
