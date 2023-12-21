import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_stream/features/now_play/view/widgets/now_button.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key, required this.playerState});
  final PlayerState? playerState;

  @override
  Widget build(BuildContext context) {
    var platformBrightness = MediaQuery.platformBrightnessOf(context);
    var color = platformBrightness == Brightness.light
        ? AppColors.kBlack
        : AppColors.kWhite;
    final processingState = playerState?.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(8).r,
        width: 56.h,
        height: 56.h,
        child: LoadingAnimationWidget.beat(
          color: color,
          size: 50.r,
        ),
      );
    } else if (AudioHelper.player.playing != true) {
      return NowButton(
        icon: CupertinoIcons.play_fill,
        onPressed: AudioHelper.player.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return NowButton(
        icon: CupertinoIcons.pause_fill,
        onPressed: AudioHelper.player.pause,
      );
    } else {
      return NowButton(
        icon: Icons.replay,
        onPressed: () {
          AudioHelper.player.seek(
            Duration.zero,
            index: AudioHelper.player.effectiveIndices?.first,
          );
        },
      );
    }
  }
}
